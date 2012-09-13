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
        commission.send("#{payment_status}!")
        commission.send("#{order_status}!")
    
        [payment_status, order_status].each do |s|
          return false [:cancel, :reject, :init, :sent, :noauth, :reject_done, :error].include?(s.gsub(/(.*\_)/, "").downcase)
        end

        true
      end
    end
  end
end
