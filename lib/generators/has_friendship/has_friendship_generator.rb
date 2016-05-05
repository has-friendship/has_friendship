require 'rails/generators'
require 'rails/generators/migration'

class HasFriendshipGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(path)
    next_num = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    current_num = current_migration_number(path)
    next_num += (current_num - next_num + 1) if current_num >= next_num
    next_num.to_s
  end

  def create_migration_file
    migration_template 'create_friendships.rb',
                       'db/migrate/create_friendships.rb'
    migration_template 'add_blocker_id_to_friendships.rb',
                       'db/migrate/add_blocker_id_to_friendships.rb'
    migration_template '../../has_friendship_update/templates/update_friendships.rb',
                       'db/migrate/update_friendships.rb'
  end
end
