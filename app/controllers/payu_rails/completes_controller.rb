require_dependency "payu_rails/application_controller"

module PayuRails
  class CompletesController < OrdersController
    def new
      @commission.completed!
    end
  end
end
