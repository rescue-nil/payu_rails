require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class CancelOrderResponse < Base
      def initialize(xml)
        @xml = xml
        self
      end

      def parse
        return false unless @xml

        # Prepare xml_doc
        xml_doc = Nokogiri::XML(@xml)
        xml_doc.remove_namespaces!

        # Fetch useful information
        status  = xml_doc.xpath("//StatusCode").text
        req_id  = xml_doc.xpath("//ResId").text

        # Find Commission depending on res_id
        commission = Commission.find_by_req_id(req_id)

        return false unless commission.present?

        # If status is correct then cancel commission.
        # Otherwise do notihing
        return case status
          when "OPENPAYU_SUCCESS"
            commission.order_cancel!
            commission.payment_cancel!
            true
          else 
            false
          end
      end
    end
  end
end
