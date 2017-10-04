class AccountsController < ApiController
  # before_action :load_account, only: [:login, :show, :create_token]
  # skip_before_action :require_login, only: [:create_token], raise: false

  def index
    render_status_ok
  end

  def show
    if account = authenticate
      render json: {
        status: true, id: account.id, token: account.token,
        username: account.username, channelID: account.channel_id
      }
    else
      render json: {
        status: false, message: "Token authentication failed"
      }
    end
  end

  def register
    account = Account.new(register_params)
    if account.save
      render json: {
        status: true, message: "Register Successful"
      }
    else
      render json: account.errors
    end
  end

  def login
    if current_account.blank?
      render json: {
        status: false, message: "Wrong password"
      }
    else
      render json: {
        status: true, id: current_account.id, token: create_token,
        username: current_account.username, channelID: current_account.channel_id
      }
    end
  end

  def logout
    destroy_token
  end

  def broadcast
    ActionCable.server.broadcast "connector-#{params[:tunnel]}", from: current_account.id, data: broadcast_data
  end

  private

  def current_account
    authenticate || Account.find_by(username: login_params[:username]).try(:authenticate, login_params[:password])
  end

  def broadcast_data
    data = params[:data]
    data[:username] = current_account.username
    data[:replyChannel]  = current_account.channel_id
    data
  end

  def login_params
    params.require(:login).permit(:username, :password)
  end

  def register_params
    params.require(:register).permit(:username, :password)
  end

end