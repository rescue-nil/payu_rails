require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class Base
      attr_accessor :response

      protected
      # Sending data to payu via POST method
      def post_data(data, url, headers = nil)
        payu_service = Net::HTTP.new(OfficialPaths.domain_url, 443)
        payu_service.use_ssl = true
        payu_service.verify_mode = OpenSSL::SSL::VERIFY_NONE 

        @response = payu_service.post(url, data.to_s, headers)
        @response.body
      end
    end
  end
end
