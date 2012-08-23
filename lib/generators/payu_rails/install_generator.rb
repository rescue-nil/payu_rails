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

      def finish_info
        readme "README" if behavior == :invoke
      end
    end
  end
end
