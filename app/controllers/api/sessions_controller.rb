class Api::SessionsController < Api::BaseController
  before_filter :require_authentication, only: :destroy
  def create
    if !signed_in?
      user = User.find_by_email(sign_in_params[:email]).authenticate(sign_in_params[:password])
      if user
        user.reset_auth_token!
        render json: user.authentication_data_hash
      end
    end
  end


  def destroy
    if signed_in?
      current_user.reset_auth_token!
    end
  end

  private
  def sign_in_params
    params.permit(:email, :password)
  end

end
