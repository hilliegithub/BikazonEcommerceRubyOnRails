class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many_attached :images
  paginates_per 10
  validates :productname, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :amountinstock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
