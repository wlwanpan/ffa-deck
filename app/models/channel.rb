class Channel < ApplicationRecord

  has_many :accounts, through: :tunnels

end