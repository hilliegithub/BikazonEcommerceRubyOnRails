class MakePasswordOptionalInAccounts < ActiveRecord::Migration[7.0]
  def change
    change_column :accounts, :password, :string, null: true
  end
end
