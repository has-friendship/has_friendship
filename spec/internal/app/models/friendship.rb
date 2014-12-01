class Friendship < ActiveRecord::Base

  def self.check_one_side(friendable, friend)
    find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id).present?
  end

  def self.exist?(friendable, friend)
    check_one_side(friendable, friend) && check_one_side(friend, friendable)
  end

  def self.find_friendship(friendable, friend)
    Friendship.find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
  end
end
