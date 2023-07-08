class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :productname
      t.decimal :price
      t.integer :amountinstock

      t.timestamps
    end
  end
end
