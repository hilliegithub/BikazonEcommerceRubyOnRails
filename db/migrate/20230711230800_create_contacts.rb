class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :phonenumber
      t.string :email
      t.text :openinghours
      t.text :faq
      t.timestamps
    end
  end
end
