if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddBlockerIdToFriendships < ActiveRecord::Migration[4.2]; end
else
  class AddBlockerIdToFriendships < ActiveRecord::Migration; end
end

AddBlockerIdToFriendships.class_eval do
  def self.up
    add_column :friendships, :blocker_id, :integer, default: nil
  end

  def self.down
    remove_column :friendships, :blocker_id
  end
end
