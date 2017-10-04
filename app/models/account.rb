class Account < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :username, uniqueness: { case_sensitive: false }, on: :create,
            if: Proc.new { Account.find_by(username: self.username).present? }
  validates :password, on: :create, length: { in: 5..20 }

  after_create Proc.new { self.update_column :channel_id, SecureRandom.uuid }

  has_many :games, dependent: :destroy

  def invalidate_token
    self.update_columns(token: nil)
  end

end
