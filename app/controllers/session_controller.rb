class SessionController < ApiController
  # skip_before_action :require_login, only: [:create], raise: false

  def create
    puts "yesss"
    if account = Account.valid_login?(params[:email], params[:password])
      allow_token_to_be_used_only_once_for(account)
      send_auth_token_for_valid_login_of(account)
    else
      render_unauthorized("Error with your login or password")
    end
  end

  def destroy
    logout
    render status: 200
  end

  private

  def allow_token_to_be_used_only_once_for(account)
    account.regenerate_token
  end

  def send_auth_token_for_valid_login_of(account)
    render json: { token: account.token }
  end

  def logout
    current_account.invalidate_token
  end

end
