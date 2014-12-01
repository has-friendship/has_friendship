class HasFriendshipMigration < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.references :friendable
      t.integer  :friend_id
      t.string   :status
      
      t.timestamps
    end
  end

end