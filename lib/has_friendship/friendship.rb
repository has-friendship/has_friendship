module HasFriendship
  class Friendship < ActiveRecord::Base

    def self.check_one_side(friendable, friend)
      find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id).present?
    end

    def self.exist?(friendable, friend)
      check_one_side(friendable, friend) && check_one_side(friend, friendable)
    end

    def self.find_friendship(friendable, friend)
      where(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id).where("status != ?", "blocked")
    end

    def self.find_relations(friendable, friend)
      where(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
    end
  end
end
