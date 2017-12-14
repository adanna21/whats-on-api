class UsersController < ApiController
  before_action :require_login, except: [:create]

  def create
    user = User.create!(user_params)
    if user.save
      render json: { token: user.auth_token }
    else
      render json: user.errors
  end

  # this method gives info about current user info  instead of user/id
  def profile
    user = User.find_by_auth_token!(request.headers[:token])
    render json: { user: { userame: user.username, email: user.email } }
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end