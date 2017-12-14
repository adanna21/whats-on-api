class ApiController < ApplicationController
  # this contoller's methods reused at other two controllers
  # if token is not valid throw error, token means user is logged in
  def require_login
    authenticate_token || render_unauthorized("Access Denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  protected

  # render errors with json saying status unauth
  def render_unauthorized(message)
    errors = { errors: [detail: message ] }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
    # below method is provided by rails
    # could us |token, option| but we don't need option, however will throw error without options
    authenticate_with_http_token do | token, options |
      User.find_by(auth_token: token)
    end
  end
end
