if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddUniqueIndexToFriendableType < ActiveRecord::Migration[4.2]; end
else
  class AddUniqueIndexToFriendableType < ActiveRecord::Migration; end
end

AddUniqueIndexToFriendableType.class_eval do
  disable_ddl_transaction!

  def self.up
    return if index_exists?(:friendships, [:friendable_type, :friendable_id, :friend_id])

    options = { unique: true, name: 'unique_friendships_index' }

    adapter_name = connection.adapter_name.downcase
    if adapter_name.include?('mysql') || adapter_name.include?('postgres')
        adapter_name.include?('postgis')
      # These are the only DB adapters that support an index algorithm.
      options[:algorithm] = :concurrently
    end

    add_index :friendships,
      [:friendable_type, :friendable_id, :friend_id],
      **options

    remove_index :friendships, name: :index_friendships_on_friendable_id_and_friend_id
  end

  def self.down
    return unless index_exists?(:friendships, [:friendable_type, :friendable_id, :friend_id])

    options = { unique: true }

    adapter_name = connection.adapter_name.downcase
    if adapter_name.include?('mysql') || adapter_name.include?('postgres')
        adapter_name.include?('postgis')
      # These are the only DB adapters that support an index algorithm.
      options[:algorithm] = :concurrently
    end

    add_index :friendships, [:friendable_id, :friend_id], **options

    remove_index :friendships, name: :unique_friendships_index

  end
end
