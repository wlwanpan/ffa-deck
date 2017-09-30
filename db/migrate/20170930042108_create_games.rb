class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :account_id
      t.integer :member_limit
      t.string :game_channel_uuid
      t.text :members
      t.string :game_name

      t.timestamps
    end
  end
end
