class Friendship < ActiveRecord::Base
  belongs_to :friendable, polymorphic: true
  # TODO: change class name from User input
  belongs_to :friend, class_name: "Friendable", foreign_key: :friend_id

  def self.check_one_side(friendable, friend)
    find_by(friendable_id: friendable.id, friendable_type: friendable.class.base_class.name, friend_id: friend.id).present?
  end

  def self.exist?(friendable, friend)
    check_one_side(friendable, friend) && check_one_side(friend, friendable)
  end
end
