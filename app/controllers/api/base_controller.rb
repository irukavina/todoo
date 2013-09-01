class Api::BaseController < ApplicationController
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