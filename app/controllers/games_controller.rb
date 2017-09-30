class GamesController < ApiController
  before_action :authenticate_account, only: [:create, :index, :destroy]

  def index
  end

  def create
    new_game = Game.new
    if @current_account.games << new_game
      render json: {
        gameID: new_game.id, channelID: new_game.game_channel_uuid
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

  def authenticate_account
    @current_account = authenticate
  end

end