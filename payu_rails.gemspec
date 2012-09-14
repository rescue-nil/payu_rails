$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "payu_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "payu_rails"
  s.version     = PayuRails::VERSION
  s.authors     = ["Piotr Gebala"]
  s.email       = ["piotrek.gebala@gmail.com"]
  s.homepage    = "https://github.com/petergebala/payu_rails"
  s.summary     = "Integration with PayU API."
  s.description = "Integration with PayU API."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  # MAIN
  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency 'oauth2'
  s.add_dependency 'nokogiri'
  s.add_dependency 'state_machine', '~> 1.1.2'
  s.add_dependency 'twitter-bootstrap-rails', '~> 2.1.2'

  # TEST
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.11"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "hirb"
  s.add_development_dependency "quiet_assets"
end
