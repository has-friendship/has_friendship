module FriendshipMacros
  def create_request(friendable, friend)
    HasFriendship::Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id, status: 'pending')
    HasFriendship::Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id, status: 'requested')
  end

  def create_friendship(friendable, friend, status: 'accepted', blocker_id: nil)
    HasFriendship::Friendship.create(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id, status: status, blocker_id: blocker_id)
    HasFriendship::Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: friendable.id, status: status, blocker_id: blocker_id)
  end

  def find_friendship_record(friendable, friend)
    HasFriendship::Friendship.find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id)
  end
end
