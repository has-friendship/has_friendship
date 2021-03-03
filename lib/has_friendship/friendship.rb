module HasFriendship
  class Friendship < ActiveRecord::Base
    validate :satisfy_custom_conditions
    has_secure_token :invitation_token

    after_create do |record|
      friend.on_friendship_created(record)
    end

    after_destroy do |record|
      friendable.try(:on_friendship_destroyed, record)
    end

    enum status: { pending: 0, requested: 1, accepted: 2, blocked: 3 } do
      event :accept do
        transition [:pending, :requested] => :accepted

        after do
          friendable.on_friendship_accepted(self)
        end
      end

      event :block do
        after do
          friendable.on_friendship_blocked(self)
        end
        transition all - [:blocked] => :blocked
      end
    end

    def block_by(blocker)
      self.blocker_id = blocker.id
      self.block!
    end

    def self.relation_attributes(one, other, status: nil)
      attr = {
        friendable_id: one.id,
        friendable_type: one.class.base_class.name,
        friend_id: other.id
      }

      if status
        attr[:status] = status
      end

      attr
    end

    def self.create_relation(one, other, options)
      relation = new relation_attributes(one, other)
      relation.attributes = options
      relation.save
    end

    def self.find_relation(friendable, friend, status: nil)
      where relation_attributes(friendable, friend, status: status)
    end

    def self.exist?(friendable, friend)
      find_relation(friendable, friend).any? && find_relation(friend, friendable).any?
    end

    def self.find_unblocked_friendship(friendable, friend)
      find_relation(friendable, friend).where.not(status: 3).first
    end

    def self.find_blocked_friendship(friendable, friend)
      find_relation(friendable, friend).where(status: 3).first
    end

    def self.find_one_side(one, other)
      find_by(relation_attributes(one, other))
    end

    private

    def satisfy_custom_conditions
      return unless friend.respond_to?(:friendship_errors)

      friend.friendship_errors(friendable).to_a.each do |friendship_error|
        errors.add(:base, friendship_error)
      end
    end
  end
end
