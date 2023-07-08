class Order < ApplicationRecord
  validates :orderdate, presence: true
  validates :shippingAddress, presence: true
  validates :paymentmethod, presence: true
  validates :status, presence: true
  validates :pst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :gst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :hst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

end
