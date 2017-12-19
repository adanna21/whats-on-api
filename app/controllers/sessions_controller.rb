class SessionsController < ApiController
  # this controler inherits fron api controller

  # must be logged in to do everything except creating a user
  skip_before_action :require_login, only: [:create], raise: false

  # Post /login
  def create
    puts params
    if user = User.validate_login(params[:username], params[:password])
      allow_token_to_be_used_only_once_for(user)
      send_token_for_valid_login_of(user)
    else
      render_unauthorized('Error with your login or password')
    end
  end

  # for logging out
  def destroy
    logout
    head :ok
  end

  private

  def send_token_for_valid_login_of(user)
    render json: { token: user.auth_token }
  end

  def allow_token_to_be_used_only_once_for(user)
    user.regenerate_auth_token
  end

  # current_user is api controller method
  def logout
    current_user.invalidate_token
  end
end
