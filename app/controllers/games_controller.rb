class GamesController < ApiController
  include Multiplexer
  include ActiveModel::Serialization
  before_action :authenticate_account, only: [:create, :destroy, :update]

  def index
  end

  def show
    # add check to allow only invited members to view channel
    current_game = Game.find(params[:id])
    if current_game
      render json: {
        id: current_game.id, ownerID: current_game.account_id,
        members: current_game.members
      }
    end
  end

  def broadcast
    current_game = Game.find(params[:id])
    output_data = params[:data]
    if current_game
      account_id_lst = current_game.members || []
      account_id_lst.push(current_game.account_id) # to change so owner is already in members list

      output_data = output_data.merge({
          gameID: current_game.id,
          status: "game-channel"
        })

      broadcast_to_multiple(account_id_lst, output_data)
    else
      render json: { status: 'sent' }
    end
  end

  def update
    # update members seperately
    if @current_account.update_attributes(update_params)
      render_status_ok
    else
      render json: {
        errors: "Cannot update game"
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

  def members_params
    params.require(:gameData).permit( :members )
  end

  def update_params
    params.require(:gameData).permit( :member_limit, :game_name )
  end

  def authenticate_account
    @current_account ||= authenticate
  end

end