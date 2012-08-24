module PayuRails
  class Engine < ::Rails::Engine
    isolate_namespace PayuRails

    initializer 'payu_rails.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper PayuRails::ExportHelper
      end
    end
  end
end
