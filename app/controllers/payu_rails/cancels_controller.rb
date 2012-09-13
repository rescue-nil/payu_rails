require_dependency "payu_rails/application_controller"

module PayuRails
  class CancelsController < OrdersController
    def new
      @commission.canceled!
    end
  end
end
