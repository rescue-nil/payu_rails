require_dependency "payu_rails/application_controller"

module PayuRails
  class CompletesController < OrdersController
    def new
      error_code = params[:error]
      flash[:alert] = Utils::Mappings::ERROR_CODES[error_code]
      # only render
    end
  end
end
