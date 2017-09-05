class ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def require_login
    authenticate || render_unauthorized("Access denied")
  end

  protected

  def render_unauthorized(message)
    errors = { errors: [ { detail: message } ] }
    render json: errors, status: :unauthorized
  end

  private

  def create_token
    current_account.regenerate_token
    current_account.token
  end

  def destroy_token
    authenticate.invalidate_token
  end

  def authenticate
    authenticate_with_http_token do |token, options|
      if account = Account.find_by(token: token)
        ActiveSupport::SecurityUtils.secure_compare(
                        ::Digest::SHA256.hexdigest(token),
                        ::Digest::SHA256.hexdigest(account.token))
        account
      end
    end
  end  
end
