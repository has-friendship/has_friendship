require 'rails_helper'

describe Friendship do
  it { should belong_to(:friendable) }
  it { should belong_to(:friend).class_name('Friendable').with_foreign_key(:friend_id) }
end