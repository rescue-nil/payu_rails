module PayuRails
  module Connection
    class NotifyOrderResponse
      def initialize(xml, commission)
        @xml, @commission = xml, commission
        self
      end

      def parse
        xml_doc = Nokogiri::XML(@xml)
        xml_doc.remove_namespaces!

        # Fetch useful information
        payment_status = xml_doc.xpath("//PaymentStatus").text
        order_status   = xml_doc.xpath("//OrderStatus").text
        req_id         = xml_doc.xpath("//ResId").text
        
        # Find Commission depending on res_id
        commission = Commission.find_by_req_id(req_id)

        return case status
          when ""
            commission.created!
            true
          when *Utils::Mappings::RESPONSE_STATUSES.keys
            commission.error!
            raise Errors::PaymentResponseError, "#{status}: #{xml_doc.xpath("//StatusDesc").text}"
          else
            commission.aborted!
            false
        end
      end
    end
  end
end
