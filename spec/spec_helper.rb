require 'rubygems'
require 'spork'
require 'rake'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

  Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
  end
end

Spork.each_run do
  Dir[File.join(ENGINE_RAILS_ROOT, "app/models/payu_rails/*.rb")].each {|f| load f }
  Dir[File.join(ENGINE_RAILS_ROOT, "lib/payu_rails/*.rb")].each {|f| load f }
  Dir[File.join(ENGINE_RAILS_ROOT, "app/controllers/payu_rails/*.rb")].each {|f| load f }
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
