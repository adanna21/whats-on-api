class ShowsController < ApiController
  before_action :require_login

  def index
    shows = Show.all.includes(:user)
    render json: { shows: shows.map(&:serialize) }
  end

  def show
    show = show.find(params[:id])
    show_user = Show.user
    render json: { show: show, user: show_user.username }
  end

  def create
    show = Show.new(show_params)
    show.user = current_user
    if show.save
      render json: {
        message: 'ok',
        show: show,
      }
    else
      render json: {message: 'Could not add show to the watchlist'}
    end
  end

  def destroy
    show = show.find(params[:id])
    show.destroy!
    render json: {message: "#{show.name} deleted"}
  end

  private
  def show_params
    params.require(:show).permit(:name, :trakt_id, :tvdb_id,:image_url)
  end

end
