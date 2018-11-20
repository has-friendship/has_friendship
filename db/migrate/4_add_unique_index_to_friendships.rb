if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddUniqueIndexToFriendships < ActiveRecord::Migration[4.2]; end
else
  class AddUniqueIndexToFriendships < ActiveRecord::Migration; end
end

AddUniqueIndexToFriendships.class_eval do
  disable_ddl_transaction!

  def self.up
    add_index :friendships, [:friendable_id, :friend_id], unique: true, algorithm: :concurrently unless index_exists? (:friendable_id, :friend_id)
  end

  def self.down
    remove_index :friendships, [:friendable_id, :friend_id]
  end
end
