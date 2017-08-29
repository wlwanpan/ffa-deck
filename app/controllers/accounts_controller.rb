class AccountsController < SessionController
  before_action :load_account, only: [:login, :show, :create_token]

  def index
    render status: 200
  end

  def show
    render status: 200
  end

  def register
    if Account.find_by(username: register_params[:username])
      render json: { message: "Account already exist", status: 403 }
    else
      account = Account.new(register_params)
      if account.save
        render json: { message: "valid", status: 200 }
      else
        render json: { message: "invalid" }
      end
    end
  end

  def login
    if @account.nil?
      render json: { exist: false }
    else
      render json: { exist: true, token: create_token }
    end
  end

  private

  def load_account
    @account ||= Account.find_by(username: login_params[:username]).try(:authenticate, login_params[:password])
  end

  def login_params
    params.require(:login).permit(:username, :password)
  end

  def register_params
    # params.require(:register).permit(:username, :email, :password, :password_confirmation)
    params.require(:register).permit(:username, :password)
  end

end