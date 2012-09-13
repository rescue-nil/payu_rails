require_dependency "payu_rails/application_controller"

module PayuRails
  class OrdersController < ApplicationController
    before_filter :setup_commission

    protected
    def setup_commission
      @commission = Commission.find(params[:commission_id])
      @product = @commission.entity
    end
  end
end
