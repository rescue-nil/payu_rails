require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class NotifyOrderResponse < Base
      def initialize(xml)
        @xml = xml
      end

      def execute
        headers = generate_headers

        data = CGI::escape("#{@xml}")
        { :body => "DOCUMENT=#{data}",  :headers => headers }
      end
    end
  end
end
