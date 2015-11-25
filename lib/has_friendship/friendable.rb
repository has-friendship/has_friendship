module HasFriendship
  module Friendable

    def friendable?
      false
    end

    def has_friendship

      class_eval do
        has_many :friendships, as: :friendable, class_name: "HasFriendship::Friendship", dependent: :destroy

        has_many :blocked_friends,
                  -> { where friendships: { status: 'blocked' } },
                  through: :friendships


        has_many :friends,
                  -> { where friendships: { status: 'accepted' } },
                  through: :friendships

        has_many :requested_friends,
                  -> { where friendships: { status: 'requested' } },
                  through: :friendships,
                  source: :friend

        has_many :pending_friends,
                  -> { where friendships: { status: 'pending' } },
                  through: :friendships,
                  source: :friend

        def self.friendable?
          true
        end
      end

      include HasFriendship::Friendable::InstanceMethods
      include HasFriendship::Extender
    end

    module InstanceMethods

      def friend_request(friend)
        unless self == friend || HasFriendship::Friendship.exist?(self, friend)
          transaction do
            HasFriendship::Friendship.create(friendable_id: self.id, friendable_type: self.class.base_class.name, friend_id: friend.id, status: 'pending')
            HasFriendship::Friendship.create(friendable_id: friend.id, friendable_type: friend.class.base_class.name, friend_id: self.id, status: 'requested')
          end
        end
      end

      def accept_request(friend)
        friend_engine(friend) do |one, other|
           HasFriendship::Friendship.find_friendship(one, other).update(status: 'accepted' )
        end
      end

      def decline_request(friend)
        friend_engine(friend) do |one, other|
          HasFriendship::Friendship.find_friendship(one, other).destroy
        end
      end

      alias_method :remove_friend, :decline_request

      def block_friend(friend)
        friend_engine(friend) do |one, other|
          HasFriendship::Friendship.find_friendship(one, other).update(status: 'blocked' )
        end
      end


      def friend_engine(friend)
        transaction do
          yield(self, friend)
          yield(friend, self)
        end
      end

      def friends_with?(friend)
        HasFriendship::Friendship.where(friendable_id: self.id, friend_id: friend.id, status: 'accepted').present?
      end

    end
  end
end
