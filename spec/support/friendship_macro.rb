module FriendshipMacros
  def create_oneside_friendship(friendable, friend)
    Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
  end

  def create_friendship(friendable, friend)
    Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
    Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id)
  end
end