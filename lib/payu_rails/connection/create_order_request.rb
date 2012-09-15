require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class CreateOrderRequest < Base
      def initialize(xml)
        @xml = xml
        self
      end

      def execute
        return false unless @xml.present?

        data    = CGI::escape("#{@xml}")
        headers = generate_headers
        url     = OfficialPaths.order_create_request_url
        result  = post_data("DOCUMENT=#{data}", url, headers)

        CreateOrderResponse.new(result).parse
      end
    end
  end
end
