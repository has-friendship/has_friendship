require 'rails/generators'
require 'rails/generators/migration'

class HasFriendshipGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_migration_file
    migration_template 'create_friendships.rb',
                       'db/migrate/create_friendships.rb'
    migration_template 'add_blocker_id_to_friendships.rb',
                       'db/migrate/add_blocker_id_to_friendships.rb'
  end
end
