class GamesController < ApiController
  before_action :authenticate_account, only: [:create, :index, :destroy]

  def index
  end

  def show
    current_game = Game.find(params[:id])
    if current_game
      render json: {
        id: current_game.id, ownerID: current_game.account_id,
        channelID: current_game.game_channel_uuid, members: current_game.members
      }
    end
  end

  def update
  end

  def create
    new_game = Game.new
    if @current_account.games << new_game
      render json: {
        id: new_game.id, channelID: new_game.game_channel_uuid,
        ownerID: new_game.account_id
      }
    else
      render json: {
        errors: new_game.errors
      }
    end
  end

  def destroy
    # Game.find(params[:id]).delete => which one to use
    if @current_account.games.find(params[:id]).delete
      render_status_ok
    end
  end

  private

  def update_params
    params.require(:gameData).permit(

    )
  end

  def authenticate_account
    @current_account = authenticate
  end

end