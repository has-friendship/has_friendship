module HasFriendship
  module Friendable

    def friendable?
      false
    end

    def has_friendship
      
      class_eval do
        has_many :friendships, dependent: :destroy
        has_many :friends, 
                  -> { where(status: 'accepted') },
                  through: :friendships

        has_many :requested_friends,
                  -> { where(status: 'requested') },
                  through: :friendships,
                  source: :friend

        has_many :pending_friends,
                  -> { where(status: 'pending') },
                  through: :friendships,
                  source: :friend

        def self.friendable?
          true
        end
      end
    end
  end
end