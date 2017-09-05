class CreateChannel < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|
      t.string :uuid
      t.integer :account_id
      t.integer :encrypted_address
      t.timestamps
    end
    add_index :channels, :uuid
  end
end
