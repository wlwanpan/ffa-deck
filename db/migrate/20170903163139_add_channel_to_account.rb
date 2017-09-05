class AddChannelToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :channel_id, :integer
  end
end
