require_dependency "payu_rails/application_controller"

module PayuRails
  class AccessTokensController < ApplicationController
    def new
      @code = params[:code]
      at = PayuRails.get_access_token_by_code(@code, :redirect_uri => new_payment_pay_access_token_url(@payment))
      redirect_to "#{PayuRails.summary_url}sessionId=#{PayuRails::Commission.last.req_id}&oauth_token=#{at.token}"
    end
  end
end
