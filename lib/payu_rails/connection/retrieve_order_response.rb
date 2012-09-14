module PayuRails
  module Connection
    class RetrieveOrderResponse
      attr_accessor :xml

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
        payment_status = xml_doc.xpath("//PaymentStatus").text.gsub("STATUS_", "").downcase
        order_status   = xml_doc.xpath("//OrderStatus").text.gsub("STATUS_", "").downcase
        req_id         = xml_doc.xpath("//ResId").text
        
        # Find Commission depending on res_id
        commission = Commission.find_by_req_id(req_id)

        return false unless commission.present?

        commission.send("#{payment_status}!")
        commission.send("#{order_status}!")
    
        req_id
      end
    end
  end
end
