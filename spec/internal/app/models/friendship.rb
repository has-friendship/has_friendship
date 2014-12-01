class Friendship < ActiveRecord::Base
  belongs_to :friendable, polymorphic: true
  # TODO: change class name from User input
  belongs_to :friend, class_name: "Friendable", foreign_key: :friend_id
end
