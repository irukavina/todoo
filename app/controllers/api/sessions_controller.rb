class Api::SessionsController < Api::BaseController
  before_filter :require_authentication, only: :destroy
  def create
    if !signed_in?
      user = User.where(email: sign_in_params[:email]).first.try(:authenticate, sign_in_params[:password])
      if user
        user.reset_auth_token!
        render json: user.authentication_data_hash, status: :created
      else
        render json: { general: ['No such login/password combination was found'] }, status: :forbidden
      end
    end
  end


  def destroy
    if signed_in?
      current_user.reset_auth_token!
      head json: :success
    else
      head json: :unauthorized
    end

  end

  private
  def sign_in_params
    params.permit(:email, :password)
  end

end
