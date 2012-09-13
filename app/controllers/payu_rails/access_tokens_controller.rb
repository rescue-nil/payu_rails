require_dependency "payu_rails/application_controller"

module PayuRails
  class AccessTokensController < ApplicationController
    def new
      @code = params[:code]
      @commission = Commission.find(params[:commission_id])
      @at = Connection::AccessToken.get_access_token_by_code(@code, :redirect_uri => payu_rails.new_commission_access_token_url(@commission))
      redirect_to "#{Connection::OfficialPaths.summary_url}?sessionId=#{@commission.session_id}&oauth_token=#{@at.token}"
    end
  end
end
