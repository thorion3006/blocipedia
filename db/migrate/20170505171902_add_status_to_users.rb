class AddStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :account_active, :boolean, default: true
  end
end
