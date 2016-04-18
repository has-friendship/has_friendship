class CreateFriendships < ActiveRecord::Migration
  def self.up
    HasFriendship::Friendship.where(status: 'pending').update_all(status: 0)
    HasFriendship::Friendship.where(status: 'requested').update_all(status: 1)
    HasFriendship::Friendship.where(status: 'accepted').update_all(status: 2)
    HasFriendship::Friendship.where(status: 'blocked').update_all(status: 3)
    change_column :friendships, :status, :integer
  end

  def self.down
    change_column :friendships, :status, :string
    HasFriendship::Friendship.where(status: 0).update_all(status: 'pending')
    HasFriendship::Friendship.where(status: 1).update_all(status: 'requested')
    HasFriendship::Friendship.where(status: 2).update_all(status: 'accepted')
    HasFriendship::Friendship.where(status: 3).update_all(status: 'blocked')
  end

end
