require_dependency "payu_rails/application_controller"

module PayuRails
  class CommissionsController < ApplicationController
    def index
      @commissions = Commission.all
    end
  
    def update
      @commission.find(params[:id])
    end
  end
end
