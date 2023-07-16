class Order < ApplicationRecord
  belongs_to :account
  has_many :order_items

  #validates :orderdate, presence: true
  validates :shippingAddress, presence: true
  validates :paymentmethod, presence: true
  validates :status, presence: true
  validates :pst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :gst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :hst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

end
