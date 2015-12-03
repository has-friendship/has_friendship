module HasFriendship
  class Friendship < ActiveRecord::Base

    def relation_attributes(one, other)
      {friendable_id: one.id, friendable_type: one.class.base_class.name, friend_id: other.id}
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
      find_relation(self, friend).where(status: 'accepted')
    end

    def self.exist?(friendable, friend)
      find_relation(friendable, friend).any? && find_relation(friend, friendable).any?
    end
# find_friendship
    def self.find_viable_friendship(friendable, friend)
      find_relation.where.not(status: "blocked").first
    end

    #this method is no longer necessary
    def self.check_one_side(friendable, friend)
      find_relation.any?
    end

  end
end
