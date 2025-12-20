if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddUniqueIndexToFriendships < ActiveRecord::Migration[4.2]; end
else
  class AddUniqueIndexToFriendships < ActiveRecord::Migration; end
end

AddUniqueIndexToFriendships.class_eval do
  disable_ddl_transaction!

  def self.up
    return if index_exists?(:friendships, [:friendable_id, :friend_id])

    options = { unique: true }

    adapter_name = connection.adapter_name.downcase
    if adapter_name.include?('mysql') || adapter_name.include?('postgres')
        adapter_name.include?('postgis')
      # These are the only DB adapters that support an index algorithm.
      options[:algorithm] = :concurrently
    end

    add_index :friendships, [:friendable_id, :friend_id], **options
  end

  def self.down
    return unless index_exists?(:friendships, [:friendable_id, :friend_id])

    remove_index :friendships, [:friendable_id, :friend_id]
  end
end
