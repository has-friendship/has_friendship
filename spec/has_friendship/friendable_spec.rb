require 'rails_helper'

describe Friendable do
  it { should have_many(:friendships) }
end