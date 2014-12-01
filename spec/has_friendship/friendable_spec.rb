require 'rails_helper'

describe Friendable do
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:friends).through(:friendships).conditions(status: 'accepted') }
  it { should have_many(:requested_friends).through(:friendships).conditions(status: 'requested') }
  it { should have_many(:pending_friends).through(:friendships).conditions(status: 'pending') }
end