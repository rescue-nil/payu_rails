module PayuRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a PayuRails initializer and copy locale files to your application."
      def copy_initializer
        template "payu_rails.rb", "config/initializers/payu_rails.rb"
      end

      def copy_migrations
        silence_stream(STDOUT) do
          silence_warnings { rake 'payu_rails:install:migrations' }
        end
      end

      # Copy adapters needed for implementing
      def copy_adapters
        template "../../payu_rails/adapters/base_adapter.rb", "app/models/payu_rails/adapters/base_adapter.rb"
        template "../../payu_rails/adapters/item_adapter.rb", "app/models/payu_rails/adapters/item_adapter.rb"
        template "../../payu_rails/adapters/order_adapter.rb", "app/models/payu_rails/adapters/order_adapter.rb"
        template "../../payu_rails/adapters/product_adapter.rb", "app/models/payu_rails/adapters/product_adapter.rb"
        template "../../payu_rails/adapters/shipping_cost_adapter.rb", "app/models/payu_rails/adapters/shipping_cost_adapter.rb"
        template "../../payu_rails/adapters/shopping_cart_adapter.rb", "app/models/payu_rails/adapters/shopping_cart_adapter.rb"
        template "../../payu_rails/adapters/unit_price_adapter.rb", "app/models/payu_rails/adapters/unit_price_adapter.rb"
      end

      def finish_info
        readme "README" if behavior == :invoke
      end
    end
  end
end
