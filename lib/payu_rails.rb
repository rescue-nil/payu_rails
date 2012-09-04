require 'oauth2'

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

require "payu_rails/connection/create_order_request"

# Adapters - Don't require it in engine. Only in application.
# require "payu_rails/adapters/base_adapter"
# require "payu_rails/adapters/item_adapter"
# require "payu_rails/adapters/order_adapter"
# require "payu_rails/adapters/product_adapter"
# require "payu_rails/adapters/shipping_cost_adapter"
# require "payu_rails/adapters/shopping_cart_adapter"
# require "payu_rails/adapters/unit_price_adapter"

module PayuRails
  mattr_accessor :pos_id
  mattr_accessor :client_secret
  mattr_accessor :client_secret_symetric
  mattr_accessor :pos_auth_key
  mattr_accessor :default_algorithm
  @@default_algorithm = "SHA-1"

  mattr_accessor :sandbox_environments
  mattr_accessor :payu_env

  mattr_accessor :payu_domain
  @@payu_domain = "payu.pl"

  mattr_accessor :payu_country
  @@payu_country = "pl"

  mattr_accessor :access_token

  mattr_accessor :notify_url
  mattr_accessor :order_cancel_url
  mattr_accessor :order_complete_url
  mattr_accessor :app_domain

  # Default way to setup module
  def self.setup
    yield self
  end

  def self.sandbox_environments=(arr)
    @@sandbox_environments = arr
    @@payu_env = arr.include?(Rails.env.to_sym) ? :sandbox : :secure
  end

  def self.domain_url
    "#{self.payu_env}.#{self.payu_domain}"
  end

  def self.base_url
    "https://#{self.domain_url}"
  end
  
  def self.summary_url
    "#{base_url}/#{self.payu_country}/standard/co/summary"
  end

  def self.auth_url
    "#{base_url}/#{self.payu_country}/standard/oauth/authorize"
  end

  def self.user_auth_url
    "#{base_url}/#{self.payu_country}/standard/oauth/user/authorize"
  end

  def self.create_order_url
    "#{base_url}/#{self.payu_country}/standard/co/openpayu/OrderCreateRequest"
  end

  def self.update_status_order_url
    "#{base_url}/#{self.payu_country}/standard/co/openpayu/OrderStatusUpdateRequest"
  end

  def self.cancel_order_url
    "#{base_url}/#{self.payu_country}/standard/co/openpayu/OrderCancelRequest"
  end

  def self.retrieve_order_url
    "#{base_url}/#{self.payu_country}/standard/co/openpayu/OrderRetrieveRequest"
  end

  def self.get_access_token
    unless @@access_token
      client = OAuth2::Client.new(@@pos_id, @@client_secret, :token_url => auth_url, :token_method => :get)
      @@access_token = client.client_credentials.get_token({}, {'auth_scheme' => 'request_body'})
    end

    @@access_token
  end

  def self.get_token
    get_access_token.token
  end

  def self.notify_url
    @@notify_url || "http://#{@@app_domain}"
  end

#  def self.inspect
#    result = []
#    class_variables.each {|e| result << "#{e} => #{class_variable_get(e)}"}
#    result.join(',')
#  end
end
