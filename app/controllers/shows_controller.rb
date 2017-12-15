class ShowsController < ApiController
  before_action :require_login

  def index
    shows = Show.where(user_id: current_user.id)
    if shows.blank?
      render json: { message: 'No shows added' }
    else
      render json: { shows: shows }
    end
  end

  # api can only give results of a show to the current user, if querry doesn't math it will throw error message
  def show
    show = Show.where('user_id = ? AND id = ?', current_user.id, params[:id])
    if show.blank?
      render json: { message: 'No show with that Id' }
    else
      render json: { show: show }
    end
  end

  def create
    show = Show.new(show_params)
    show.user = current_user
    if show.save
      render json: {
        message: 'ok',
        show: show
      }
    else
      render json: { message: 'Could not add show to the watchlist' }
    end
  end

  def destroy
    show = Show.find(params[:id])
    show.destroy!
    render json: { message: "#{show.name} deleted" }
  end

  private

  def show_params
    params.require(:show).permit(:name, :trakt_id, :tvdb_id, :image_url)
  end

end
