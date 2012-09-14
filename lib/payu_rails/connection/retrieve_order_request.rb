module PayuRails
  module Connection
    class RetrieveOrderRequest < Base
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

        access_token = Connection::AccessToken.get_system_access_token.token
        data_to_send = CGI::escape("#{@xml}")
        result  = post_data("DOCUMENT=#{data_to_send}", "#{OfficialPaths.order_retrieve_request_url}?oauth_token=#{access_token}", headers)
        RetrieveOrderResponse.new(result).parse
      end
    end
  end
end
