RAILS_VERSIONS = ['>= 4.2.0', '< 7.1'].freeze

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "has_friendship/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "has_friendship"
  s.version     = HasFriendship::VERSION
  s.authors     = ["Sung Won Cho"]
  s.email       = ["mikeswcho@gmail.com"]
  s.homepage    = "https://github.com/sungwoncho/has_friendship"
  s.summary     = "Add social network friendship features to your Active Record models."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.required_ruby_version = '>= 2.4.1'

  s.add_dependency "activesupport", RAILS_VERSIONS
  s.add_dependency "activemodel", RAILS_VERSIONS
  s.add_dependency "activerecord", RAILS_VERSIONS

  s.add_dependency "stateful_enum"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "generator_spec"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "byebug"
  # fix time zone error when opening server
  s.add_development_dependency 'tzinfo-data'

end
