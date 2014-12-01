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

      include HasFriendship::Friendable::InstanceMethods

    end

    module InstanceMethods

      def friend_request(friend)
        unless self == friend || Friendship.exist?(self, friend)
          transaction do
            Friendship.create(friendable_id: self.id, friendable_type: self.class.base_class.name, friend_id: friend.id)
            Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: self.id)
          end
        end
      end

    end
  end
end