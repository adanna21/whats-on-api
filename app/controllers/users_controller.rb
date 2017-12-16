class UsersController < ApiController
  before_action :require_login, except: [:create]
  # create! returns the actual created user and create returns true
  def create
    user = User.create!(user_params)
    if user.save
      render json: { token: user.auth_token }, status: 200
    else
      render json: user.errors, status: 422
    end
  end

  # this method gives info about current user using the user/id path
  def profile
    user = User.find_by_auth_token!(request.headers[:token])
    user_shows = user.shows
    render json: { user: { userame: user.username, email: user.email }, shows: user_shows }
  end

  # anything below private can only be used by methods in this class
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end