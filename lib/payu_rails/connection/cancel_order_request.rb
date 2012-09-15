require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class CancelOrderRequest < Base
      def initialize(xml)
        @xml = xml
        self
      end

      def execute
        return false unless @xml.present?

        access_token  = Connection::AccessToken.get_system_access_token.token

        headers = generate_headers
        url     = "#{OfficialPaths.order_cancel_request_url}?oauth_token=#{access_token}"
        data    = CGI::escape("#{@xml}")
        result  = post_data("DOCUMENT=#{data}", url, headers)

        CancelOrderResponse.new(result).parse
      end
    end
  end
end
