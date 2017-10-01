class Game < ApplicationRecord
  after_create :generate_channel_id

  attr_accessor :member_limit, :members, :game_name

  belongs_to :account
  serialize :members, Array

  def generate_channel_id
    self.update_column :game_channel_uuid, SecureRandom.uuid
  end

end