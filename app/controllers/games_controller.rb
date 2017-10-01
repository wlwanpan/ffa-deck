class GamesController < ApiController
  before_action :authenticate_account, only: [:create, :destroy, :update]

  def index
  end

  def show
    # add check to allow only invited members to view channel
    current_game = Game.find(params[:id])
    if current_game
      render json: {
        id: current_game.id, ownerID: current_game.account_id,
        channelID: current_game.game_channel_uuid, members: current_game.members
      }
    end
  end

  def update
    # update members seperately
    if @current_account.update_attributes(update_params)
      render_status_ok
    else
      render json: {
        errors: "cannot update game"
      }
    end
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
      :member_limit, :members, :game_name
    )
  end

  def authenticate_account
    @current_account = authenticate
  end

end