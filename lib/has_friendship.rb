require 'active_support'
require 'active_record'

module HasFriendship
  extend ActiveSupport::Autoload

  autoload :Friendable
end

ActiveSupport.on_load(:active_record) do
  extend HasFriendship::Friendable
end