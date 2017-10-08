class AccountsController < ApiController
  include Multiplexer
  include ActiveModel::Serialization

  before_action :current_account, only: [:show, :broadcast]

  def index
    render_status_ok
  end

  def show
    if @current_account
      output_json = @current_account.as_json(only: [:id, :username, :channel_id])
      output_json["status"] = true
      render json: output_json
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
    @current_account = Account.find_by(username: login_params[:username])
                              .try(:authenticate, login_params[:password])
    if @current_account.blank?
      render json: {
        status: false, message: "Wrong password"
      }
    else
      cache_channel(@current_account.id, @current_account.channel_id)

      output_json = @current_account.as_json(only: [:id, :username, :channel_id])
      output_json["status"] = true
      output_json["token"] = create_token

      render json: output_json
    end
  end

  def logout
    destroy_token
  end

  def broadcast
    if params[:to] == 'global'
      broadcast_to_all(@current_account.id, broadcast_data)
    else
      broadcast_to(params[:to], broadcast_data)
    end
  end

  private

  def current_account
    @current_account ||= authenticate
  end

  def broadcast_data
    data = params[:data]
    data
  end

  def login_params
    params.require(:login).permit(:username, :password)
  end

  def register_params
    params.require(:register).permit(:username, :password)
  end

end