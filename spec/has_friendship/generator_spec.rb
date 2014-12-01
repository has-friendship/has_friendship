require 'generator_spec/test_case'
require 'generators/has_friendship/has_friendship_generator'

describe HasFriendshipGenerator, type: :generator do
  include GeneratorSpec::TestCase

  destination File.expand_path("../tmp", File.dirname(__FILE__))

  before :all do
    prepare_destination
    run_generator
  end

  after :all do
    FileUtils.rm_r Dir.glob('tmp/*') # Clean up 'tmp/' after test
  end

  specify { 
    expect(destination_root).to have_structure { 
      directory "db" do
        directory "migrate" do
          migration "create_friendships"
        end
      end
    }
  }
end 