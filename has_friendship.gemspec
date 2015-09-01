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

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "generator_spec"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "byebug"
end
