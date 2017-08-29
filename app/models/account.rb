class Account < ApplicationRecord
  has_secure_password
  has_secure_token

  def invalidate_token
    self.update_columns(token: nil)
  end

end
