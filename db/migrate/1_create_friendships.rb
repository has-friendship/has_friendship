if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class CreateFriendships < ActiveRecord::Migration[4.2]; end
else
  class CreateFriendships < ActiveRecord::Migration; end
end

CreateFriendships.class_eval do
  def self.up
    create_table :friendships do |t|
      t.references :friendable, polymorphic: true
      t.integer  :friend_id
      t.string   :status

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
