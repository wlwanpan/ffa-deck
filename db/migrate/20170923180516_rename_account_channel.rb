class RenameAccountChannel < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :channel_id, :string
  end
end
