class Api::SessionsController < Api::BaseController
  before_filter :require_authentication, only: destroy
  def create
    if !signed_in?
      current_user.reset_auth_token!
      render json: current_user.auth_token_hash
    end
  end


  def destroy
    if signed_in?
      current_user.reset_auth_token!
    end
  end

end
