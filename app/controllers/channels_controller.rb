class ChannelsController < ApiController

  def create
    new_channel = authenticate.channels.create create_params
    render json: { channel: new_channel }
  end

  def index
    render json: { channels: current_account.channels }
  end

  private

  def current_account
    authenticate
  end

  def create_params
    params.require(:channel).permit(:uuid, :account_id)
  end

end