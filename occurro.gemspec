$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "occurro/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "occurro"
  s.version     = Occurro::VERSION
  s.authors     = ["Tiago Scolari"]
  s.email       = ["tscolari@gmail.com"]
  s.homepage    = "https://github.com/tscolari/occurro"
  s.summary     = "Simple counters for ActiveRecord visualizations."
  s.description = "Tasks and models for counting model visualizations."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
end
