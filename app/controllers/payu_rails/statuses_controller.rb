require_dependency "payu_rails/application_controller"

module PayuRails
  class StatusesController < OrdersController
    def create 
      # Get xml file from payu - payu system request
      req_id = Connection::NotifyOrderRequest.new(params[:DOCUMENT], @commission).parse

      xml_builder = OrderBuilders::NotifyResponse.new(@commission, :req_id => req_id)
      xml = xml_builder.build

      # Receive xml with our response
      res = Connection::NotifyOrderResponse.new(xml.to_xml).execute
      render :text => res[:body]
    end
  end
end
