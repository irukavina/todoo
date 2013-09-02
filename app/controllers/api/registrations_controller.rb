class Api::RegistrationsController < Api::BaseController
  respond_to :json

  def create
    user = User.new(registration_params)
    if user.save!
       render json: user.authentication_data_hash
    else
      head status: :unauthorized
    end
  end

  private

  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end

end
