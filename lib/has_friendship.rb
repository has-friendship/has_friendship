require 'stateful_enum'

require 'active_support'
require 'active_record'
require 'rails/engine'
require 'has_friendship/engine'

module HasFriendship
  extend ActiveSupport::Autoload

  autoload :Friendable
  autoload :Friendship
  autoload :Extender
end

ActiveSupport.on_load(:active_record) do
  extend HasFriendship::Friendable
end
