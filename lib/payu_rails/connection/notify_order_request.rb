module PayuRails
  module Connection
    class NotifyOrderRequest < Base
      def initialize(xml, commission)
        @xml, @commission = xml, commission
        self
      end

      def parse
        xml_doc = Nokogiri::XML(@xml)
        xml_doc.remove_namespaces!

        # Fetch useful information
        payment_status = xml_doc.xpath("//PaymentStatus").text.gsub("STATUS_", "").downcase
        order_status   = xml_doc.xpath("//OrderStatus").text.gsub("STATUS_", "").downcase
        req_id         = xml_doc.xpath("//ReqId").text

        return false unless @commission

        @commission.send("#{payment_status}!")
        @commission.send("#{order_status}!")
    
        req_id
      end
    end
  end
end
