class UpdateFriendships < ActiveRecord::Migration
  def self.up
    add_column :friendships, :status_temp, :integer, index: true
    HasFriendship::Friendship.where(status: 'pending').update_all(status_temp: 0)
    HasFriendship::Friendship.where(status: 'requested').update_all(status_temp: 1)
    HasFriendship::Friendship.where(status: 'accepted').update_all(status_temp: 2)
    HasFriendship::Friendship.where(status: 'blocked').update_all(status_temp: 3)
    remove_column :friendships, :status
    rename_column :friendships, :status_temp, :status
  end

  def self.down
    add_column :friendships, :status_temp, :string
    HasFriendship::Friendship.where(status: 0).update_all(status_temp: 'pending')
    HasFriendship::Friendship.where(status: 1).update_all(status_temp: 'requested')
    HasFriendship::Friendship.where(status: 2).update_all(status_temp: 'accepted')
    HasFriendship::Friendship.where(status: 3).update_all(status_temp: 'blocked')
    remove_column :friendships, :status
    rename_column :friendships, :status_temp, :status
  end
end
