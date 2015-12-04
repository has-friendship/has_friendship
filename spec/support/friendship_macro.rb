module FriendshipMacros
  def create_request(friendable, friend)
    HasFriendship::Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id, status: 'pending')
    HasFriendship::Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id, status: 'requested')
  end

  def create_friendship(friendable, friend)
    HasFriendship::Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id, status: 'accepted')
    HasFriendship::Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id, status: 'accepted')
  end

  def find_viable_friendship_record(friendable, friend)
    HasFriendship::Friendship.find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
  end
end