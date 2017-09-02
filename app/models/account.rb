class Account < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :username, uniqueness: { case_sensitive: false }, on: :create, if: :duplicate_account_username
  validates :password, on: :create, length: { in: 5..20 }

  has_many :tunnels
  has_many :channels, through: :tunnels

  def duplicate_account_username
    return true if Account.find_by_username(self.username).present?
  end

  def invalidate_token
    self.update_columns(token: nil)
  end

end
