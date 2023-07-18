class AddStripeSessionToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :stripe_session, :string
  end
end
