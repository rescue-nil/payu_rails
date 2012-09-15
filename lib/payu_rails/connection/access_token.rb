module PayuRails
  module Connection
    class AccessToken
      cattr_accessor :system_access_token
      cattr_accessor :client_access_token

      # Get user app access token depending on shop credentials.
      def self.get_system_access_token
        unless @@system_access_token
          client = OAuth2::Client.new(PayuRails.pos_id, PayuRails.client_secret, 
                                      :token_url => OfficialPaths.auth_url, 
                                      :token_method => :get)
          @@system_access_token = client.client_credentials.get_token({}, {'auth_scheme' => 'request_body'})
        end

        @@system_access_token
      end

      # Get access token depending on code.
      # Used to get user access_token based on received payu code.
      def self.get_access_token_by_code(code, *args)
        options = args.extract_options!.symbolize_keys!
        unless @@client_access_token
          client = OAuth2::Client.new(PayuRails.pos_id, PayuRails.client_secret, 
                                      :token_url => OfficialPaths.user_code_auth_url, 
                                      :token_method => :post)
          client.auth_code.authorize_url(:redirect_uri => options[:redirect_uri])
          @@client_access_token = client.auth_code.get_token(code, options)
        end

        @@client_access_token
      end
    end
  end
end
