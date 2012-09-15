require_dependency "payu_rails/application_controller"

module PayuRails
  class CancelsController < OrdersController
    def new
      xml_builder = OrderBuilders::CancelRequest.new(@commission)
      xml = xml_builder.build

      Connection::CancelOrderRequest.new(xml.to_xml).execute
      flash[:notice] = "Cancel request sent!"
    end
  end
end
