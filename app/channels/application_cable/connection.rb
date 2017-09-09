module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include ActionController::HttpAuthentication::Token::ControllerMethods
    identify_by :current_account

    def connect
      self.current_account = authenticated_account
    end


    private

    def authenticated_account
      authenticate_with_http_token do |token, options|
        if account = Account.find_by(token: token)
          ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(token), ::Digest::SHA256.hexdigest(account.token))
          account
        end
      end
    end

  end
end
