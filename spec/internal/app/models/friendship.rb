class Friendship < ActiveRecord::Base
  belongs_to :friendable, polymorphic: true
end
