module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # include ActionController::HttpAuthentication::Token::ControllerMethods
    identified_by :current_account

    def connect
      puts "Connetion called"
      puts cookies.signed[:identity_id]
      self.current_account ||= find_verified_user
    end

    def disconnect
      puts "disconnect called"
      # Any cleanup work needed when the cable connection is cut.
    end

    protected
      def find_verified_user
        if verified_user = Account.find_by(token: request.params[:token])
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
