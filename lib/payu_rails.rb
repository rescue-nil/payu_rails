# Engine requirements
require "payu_rails/engine"

module PayuRails
  mattr_accessor :pos_id
  mattr_accessor :client_secret
  mattr_accessor :client_secret_symetric
  mattr_accessor :pos_auth_key

  # Default way to setup module
  def self.setup
    yield self
  end
end
