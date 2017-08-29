class SessionController < ApiController
  # skip_before_action :require_login, only: [:create_token], raise: false

  def create_token
    allow_token_to_be_used_only_once_for(@account)
    send_auth_token_for_valid_login_of(@account)
  end

  def destroy_token
    logout
    render status: 200
  end

  private

  def allow_token_to_be_used_only_once_for(account)
    account.regenerate_token
  end

  def send_auth_token_for_valid_login_of(account)
    account.token
  end

  def logout
    current_account.invalidate_token
  end

end
