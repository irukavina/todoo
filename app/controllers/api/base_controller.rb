class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  attr_reader :current_user

  def signed_in?
    !!current_user
  end

  private
  def require_authentication
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.where(auth_token: token).first
    end
  end
end