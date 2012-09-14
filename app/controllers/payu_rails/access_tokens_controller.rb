require_dependency "payu_rails/application_controller"

module PayuRails
  class AccessTokensController < ApplicationController
    def new
      # Code recived from payu, it is needed 
      # for getting user access_token 
      @code = params[:code]

      @commission = Commission.find(params[:commission_id])

      # Fetching access_token from payu
      @access_token = Connection::AccessToken.get_access_token_by_code(@code, :redirect_uri => payu_rails.new_commission_access_token_url(@commission))

      # Redirect to payu summary page
      redirect_to "#{Connection::OfficialPaths.summary_url}?sessionId=#{@commission.session_id}&oauth_token=#{@access_token.token}"
    end
  end
end
