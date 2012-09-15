require 'oauth2'
require 'twitter-bootstrap-rails'
require 'state_machine'

# Engine requirements
require "payu_rails/engine"

# Utils
require "payu_rails/utils/mappings"
require "payu_rails/utils/crypth"

# Errors
require "payu_rails/errors/net_response_error"
require "payu_rails/errors/payment_response_error"
require "payu_rails/errors/status_error"

# XML Builders
require "payu_rails/order_builders/base"
require "payu_rails/order_builders/create_request"
require "payu_rails/order_builders/retrieve_request"
require "payu_rails/order_builders/notify_response"
require "payu_rails/order_builders/cancel_request"

# Connection to payu
require "payu_rails/connection/base"
require "payu_rails/connection/retrieve_order_request"
require "payu_rails/connection/retrieve_order_response"
require "payu_rails/connection/cancel_order_request"
require "payu_rails/connection/cancel_order_response"
require "payu_rails/connection/create_order_request"
require "payu_rails/connection/create_order_response"
require "payu_rails/connection/notify_order_request"
require "payu_rails/connection/notify_order_response"
require "payu_rails/connection/official_paths"
require "payu_rails/connection/access_token"

module PayuRails
  # Data from payu service
  # Shop credentials must be filled by user in configuration file
  mattr_accessor :pos_id
  mattr_accessor :client_secret
  mattr_accessor :client_secret_symetric
  mattr_accessor :pos_auth_key
  mattr_accessor :default_algorithm
  @@default_algorithm = "SHA-1"

  # Option tells us when use sandbox
  mattr_accessor :sandbox_environments
  @@sandbox_environments = [:development, :test, :staging]

  # Current payu environment
  mattr_accessor :payu_env
  @@payu_env = :sandbox

  # Payu official domain
  mattr_accessor :payu_domain
  @@payu_domain = "payu.pl"

  # Country, you can choose betweent :pl an :en
  mattr_accessor :payu_country
  @@payu_country = :pl

  # User system app domain or static outside IP, have to start with http://
  # The same as url filled in payu admin panel
  mattr_accessor :app_domain
  @@app_domain = "http://localhost:3000"

  # Default way to configure engine
  def self.setup
    yield self
  end

  # Overwrite sandbox_environments
  def self.sandbox_environments=(arr)
    @@sandbox_environments = arr
    @@payu_env = arr.include?(Rails.env.to_sym) ? :sandbox : :secure
  end
end
