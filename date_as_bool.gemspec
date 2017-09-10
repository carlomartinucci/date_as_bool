$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "date_as_bool/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "date_as_bool"
  s.version     = DateAsBool::VERSION
  s.authors     = ["Carlo Martinucci"]
  s.email       = ["carlo.martinucci@gmail.com"]
  s.homepage    = "https://carlomartinucci.github.io/date_as_bool"
  s.summary     = "Get both a datetime and a boolean behaviour with only one column."
  s.description = "A simple Rails Gem to get both a datetime and a boolean behaviour from the same database column, i.e. have a verified_at:datetime to log times of verification and sort, and also .verified? and .verify! methods."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
