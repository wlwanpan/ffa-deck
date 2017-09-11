class Channel < ApplicationRecord

  has_many :tunnels
  has_many :accounts, through: :tunnels

end