class DeleteUsersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
    drop_table :tunnels
    drop_table :channels
  end
end
