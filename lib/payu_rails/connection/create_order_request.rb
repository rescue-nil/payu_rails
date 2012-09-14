require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class CreateOrderRequest
      attr_accessor :xml, :response

      def initialize(xml)
        @xml = xml
        self
      end

      def execute
        return false unless @xml.present?

        digest = Utils::Crypth.signature(@xml)
        headers = {
          "OpenPayu-Signature: sender" => PayuRails.pos_id.to_s,
          "signature" => digest,
          "algorithm" => PayuRails.default_algorithm,
          "content" => "DOCUMENT"
        }

        data_to_send = CGI::escape("#{@xml}")
        result  = post_data("DOCUMENT=#{data_to_send}", OfficialPaths.order_create_request_url, headers)
        CreateOrderResponse.new(result).parse
      end

      private
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
