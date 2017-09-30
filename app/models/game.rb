class Game < ApplicationRecord
  after_initialize :generate_channel_id

  belongs_to :account
  serialize :members, Array

  def generate_channel_id
    self.game_channel_uuid = SecureRandom.uuid
  end

end