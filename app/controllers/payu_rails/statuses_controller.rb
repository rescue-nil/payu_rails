require_dependency "payu_rails/application_controller"

module PayuRails
  class StatusesController < OrdersController
    def create 
      Connection::NotifyOrderResponse.new(params[:DOCUMENT], @commission)
    end
  end
end
