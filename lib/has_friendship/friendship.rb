module HasFriendship
  class Friendship < ActiveRecord::Base
    def self.relation_attributes(one, other)
      {
        friendable_id: one.id,
        friendable_type: one.class.base_class.name,
        friend_id: other.id
      }
    end

    def self.create_relation(one, other, options)
      relation = new relation_attributes(one, other)
      relation.attributes = options
      relation.save
    end

    def self.find_relation(friendable, friend)
      where relation_attributes(friendable, friend)
    end

    def self.exist?(friendable, friend)
      find_relation(friendable, friend).any? && find_relation(friend, friendable).any?
    end

    def self.find_unblocked_friendship(friendable, friend)
      find_relation(friendable, friend).where.not(status: "blocked").first
    end

    def self.find_blocked_friendship(friendable, friend)
      find_relation(friendable, friend).where(status: "blocked").first
    end

    def self.find_one_side(one, other)
      find_by(relation_attributes(one, other))
    end
  end
end
