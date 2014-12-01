module HasFriendship
  module Friendable

    def friendable?
      false
    end

    def has_friendship
      
      class_eval do
        def self.friendable?
          true
        end
      end
    end
  end
end