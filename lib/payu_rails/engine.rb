module PayuRails
  class Engine < ::Rails::Engine
    isolate_namespace PayuRails

    # Overwrite generator configs
    config.generators do |g|
      g.javascripts false 
      g.stylesheets false
      g.helper false
      g.test_framework :rspec, :view_specs => false, :fixture => false
      g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
      g.template_engine :haml
    end

    # Include Export helper to main AC
    initializer 'payu_rails.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper PayuRails::ExportHelper
      end
    end
  end
end
