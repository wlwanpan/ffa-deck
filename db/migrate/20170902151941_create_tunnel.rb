class CreateTunnel < ActiveRecord::Migration[5.1]
  def change
    create_table :tunnels do |t|
      t.integer :account_id
      t.integer :channel_id
    end
  end
end
