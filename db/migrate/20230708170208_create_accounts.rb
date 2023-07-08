class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.string :primaryaddressstreet
      t.string :primarypostalcode
      t.string :secondaryaddressstreet
      t.string :secondarypostalcode

      t.timestamps
    end
  end
end
