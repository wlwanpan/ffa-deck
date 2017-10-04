class Game < ApplicationRecord
  attr_accessor :member_limit, :members, :game_name
  # include ActiveAttr::Model

  # attribute :game_channel_uuid, :default -> () { SecureRandom.uuid }
  # Wtf am I doing wrong =/ ^
  after_create Proc.new { self.update_column :game_channel_uuid, SecureRandom.uuid }

  belongs_to :account
  serialize :members, Array


end