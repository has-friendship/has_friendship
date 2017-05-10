class AddBlockerIdToFriendships < ActiveRecord::Migration<%= migration_version %>
  def self.up
    add_column :friendships, :blocker_id, :integer, default: nil
  end

  def self.down
    remove_column :friendships, :blocker_id
  end
end
