module PayuRails
  module Connection
    class RetrieveOrderRequest < Base
      def initialize(xml)
        @xml = xml
        self
      end
      
      def execute
        return false unless @xml.present?

        access_token = Connection::AccessToken.get_system_access_token.token

        headers = generate_headers
        data    = CGI::escape("#{@xml}")
        url     = "#{OfficialPaths.order_retrieve_request_url}?oauth_token=#{access_token}"
        result  = post_data("DOCUMENT=#{data}", url, headers)

        RetrieveOrderResponse.new(result).parse
      end
    end
  end
end
