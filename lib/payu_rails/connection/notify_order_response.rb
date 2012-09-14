require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class NotifyOrderResponse
      attr_accessor :xml, :status
      
      def initialize(xml)
        @xml = xml
      end

      def execute
        digest = Utils::Crypth.signature(@xml)
        headers = {
          "OpenPayu-Signature: sender" => PayuRails.pos_id.to_s,
          "signature" => digest,
          "algorithm" => PayuRails.default_algorithm,
          "content" => "DOCUMENT"
        }

        data_to_send = CGI::escape("#{@xml}")
        ["DOCUMENT=#{data_to_send}",  headers]
      end
    end
  end
end
