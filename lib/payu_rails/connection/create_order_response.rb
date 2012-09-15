module PayuRails
  module Connection
    class CreateOrderResponse < Base
      def initialize(xml)
        @xml = xml
        self
      end

      # Parsing response form Payu, extracting status
      # and depedning on it return true/fasle or raise an error
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

        return case status
          when "OPENPAYU_SUCCESS"
            commission.order_new!
            commission.payment_new!
            true
          when *(Utils::Mappings::RESPONSE_STATUSES.keys - ["OPENPAYU_SUCCESS"])
            commission.order_cancel!
            commission.payment_error!
            raise Errors::PaymentResponseError, "#{status}: #{xml_doc.xpath("//StatusDesc").text}"
          else
            commission.order_cancel!
            commission.payment_error!
            false
        end
      end
    end
  end
end
