class Api::RegistrationsController < Api::BaseController
  respond_to :json

  def create
    user = User.new(registration_params)
    if user.valid? && user.save
       render json: user.authentication_data_hash, status: :created
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    head status: :unprocessable_entity
  end

  private

  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end

end
