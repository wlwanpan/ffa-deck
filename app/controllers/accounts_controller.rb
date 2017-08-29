class AccountsController < ActionController::API

  before_action :load_account, only: [:login, :show]

  def index
    render status: 200
  end

  def show
    render status: 200
  end

  def register
    account = Account.new(register_params)
    if account.save
      render status: 200
    else
      puts "fail"
    end
  end

  def login
    if @account.nil?
      render json: { exist: false }
    else
      render json: { exist: true, username: @account.username }
    end
  end

  private

  def load_account
    @account ||= Account.find_by(username: login_params[:username])
                        .try(:authenticate, login_params[:password])
  end

  def login_params
    params.require(:login).permit(:username, :password)
  end

  def register_params
    params.require(:register).permit(:username, :email, :password, :password_confirmation)
  end

end