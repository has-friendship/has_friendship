module HasFriendship
  class Friendship < ActiveRecord::Base

    after_create do
      friend.on_friendship_created(self)
    end

    before_destroy do
      friendable.on_friendship_destroyed(self)
    end

    enum status: { pending: 0, requested: 1, accepted: 2, blocked: 3 } do
      event :accept do
        transition [:pending, :requested] => :accepted

        after do
          friendable.on_friendship_accepted(self)
        end
      end

      event :block do
        before do
          self.blocker_id = self.friendable.id
        end

        after do
          friendable.on_friendship_blocked(self)
        end
        transition all - [:blocked] => :blocked
      end
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
  end
end
