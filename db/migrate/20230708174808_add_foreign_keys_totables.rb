class AddForeignKeysTotables < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :category
    add_reference :accounts, :primary_province, foreign_key: { to_table: :provinces }
    add_reference :accounts, :secondary_province, foreign_key: { to_table: :provinces }
    add_reference :orders, :account
    add_reference :order_items, :order
    add_reference :order_items, :product
  end
end
