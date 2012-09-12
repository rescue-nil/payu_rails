$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payu_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payu_rails"
  s.version     = PayuRails::VERSION
  s.authors     = ["Piotr Gebala"]
  s.email       = ["piotrek.gebala@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of PayuRails."
  s.description = "TODO: Description of PayuRails."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency 'oauth2'
  s.add_dependency 'nokogiri'
  s.add_dependency 'state_machine', '~> 1.1.2'
  s.add_dependency 'twitter-bootstrap-rails', '~> 2.1.2'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
end
