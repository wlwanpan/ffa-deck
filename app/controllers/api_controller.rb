class ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  def require_login
    authenticate_token || render_unauthorized("Access denied")
  end

  def current_account
    @current_user ||= authenticate_token
  end

  protected

  def render_unauthorized(message)
    errors = { errors: [ { detail: message } ] }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
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
