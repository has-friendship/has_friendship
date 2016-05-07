require 'generator_spec/test_case'
require 'generators/has_friendship_update/has_friendship_update_generator'

describe HasFriendshipUpdateGenerator, type: :generator do
  include GeneratorSpec::TestCase

  destination File.expand_path("../tmp", File.dirname(__FILE__))

  before :all do
    prepare_destination
    run_generator
  end

  after :all do
    FileUtils.rm_r Dir.glob('spec/tmp/*') # Clean up 'tmp/' after test
  end

  describe "generated migrations" do
    it "should have a unique version number" do
      unique_migration_nums = []
      migration_files = Dir.glob('spec/tmp/db/migrate/*').each do |file|
        migration_num = File.basename(file).split("_").first.to_i
        unique_migration_nums << migration_num unless unique_migration_nums.include? migration_num
      end
      expect(unique_migration_nums.count).to eq(migration_files.count)
    end
  end

  specify {
    expect(destination_root).to have_structure {
      directory "db" do
        directory "migrate" do
          migration "update_friendships"
        end
      end
    }
  }
end
