require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class CreateOrderRequest < Base
      attr_accessor :xml

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
    end
  end
end
