class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :account_id
      t.string :channel_id
      t.text :game_settings
      t.text :members
      t.string :game_name

      t.timestamps
    end
  end
end
