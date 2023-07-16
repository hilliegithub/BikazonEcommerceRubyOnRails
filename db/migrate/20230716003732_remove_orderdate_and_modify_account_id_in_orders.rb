class RemoveOrderdateAndModifyAccountIdInOrders < ActiveRecord::Migration[7.0]
  def change
    # Removeing the orderdate column
    remove_column :orders, :orderdate, :date

    # Modifying the account_id column to accept null values
    change_column :orders, :account_id, :integer, null: true
  end
end
