require 'stateful_enum'

require 'active_support'
require 'active_record'

module HasFriendship
  extend ActiveSupport::Autoload

  autoload :Friendable
  autoload :Friendship
  autoload :Extender
end

ActiveSupport.on_load(:active_record) do
  extend HasFriendship::Friendable
end