class Game < ApplicationRecord
  attr_accessor :member_limit, :members, :game_name

  after_create Proc.new { self.update_column :channel_id, SecureRandom.uuid }

  belongs_to :account
  serialize :members, Array
  serialize :game_settings, JSON

end