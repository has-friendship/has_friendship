module HasFriendship
  class Friendship < ActiveRecord::Base

    def self.relation_attributes(one, other)
      {friendable_id: one.id,
       friendable_type: one.class.base_class.name,
      friend_id: other.id}
    end

    def self.create_relation(one, other, options)
      relation = new relation_attributes(one, other)
      relation.attributes = options
      relation.save
    end

    def self.find_relation(friendable, friend)
      where relation_attributes(friendable, friend)
    end

    def self.find_friend(friendable, friend)
      find_relation(friendable, friend).where(status: 'accepted')
    end

    def self.exist?(friendable, friend)
      find_relation(friendable, friend).any? && find_relation(friend, friendable).any?
    end

    # find not blocked frienships
    def self.find_viable_friendship(friendable, friend)
      find_relation(friendable, friend).where.not(status: "blocked").first
    end

    singleton_class.send(:alias_method, :find_friendship, :find_viable_friendship )

    #this method is no longer necessary
    def self.check_one_side(friendable, friend)
      find_relation(friendable, friend).any?
    end

  end
end
