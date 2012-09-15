# Overwriten controller form payu_rails engine
module PayuRails
  class CompletesController < OrdersController
    layout 'application'
    include ::StepsExtension

    before_filter :set_page, :only => :new

    def new
      error_code = params[:error]
      flash[:alert] = Utils::Mappings::ERROR_CODES[error_code.to_i]
    end

    private
    def set_page
      set_current!(:third)
    end
  end
end
