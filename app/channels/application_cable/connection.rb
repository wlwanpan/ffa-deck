module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account

    def connect
      self.current_account ||= find_verified_user
    end

    def disconnect
      puts "disconnect called"
    end

    protected
      def find_verified_user
        token = request.params[:token]
        if verified_user = Account.find_by(token: token)
          ActiveSupport::SecurityUtils.secure_compare( ::Digest::SHA256.hexdigest(token), ::Digest::SHA256.hexdigest(verified_user.token) )
          verified_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
