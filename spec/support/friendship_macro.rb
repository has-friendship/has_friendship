module FriendshipMacros
  def create_request(friendable, friend)
    Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id, status: 'pending')
    Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id, status: 'requested')
  end

  def create_friendship(friendable, friend)
    Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id, status: 'accepted')
    Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id, status: 'accepted')
  end

  def find_friendship_record(friendable, friend)
    Friendship.find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
  end
end