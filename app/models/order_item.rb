class OrderItem < ApplicationRecord
    validates :quantity, :price, presence: true
    validates :quantity, numericality: { only_integer: true }
    validates :price, numericality: { greater_than: 0 }
end
