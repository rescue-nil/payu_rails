require_dependency "payu_rails/application_controller"

module PayuRails
  class StatusesController < OrdersController
    def create 
      result = Connection::NotifyOrderResponse.new(params[:DOCUMENT], @commission)
      raise "todo"
      if ok
        to wyślij odpowiedni resposne
      else
        to odeślij inny response
      end
    end
  end
end
