class Category < ApplicationRecord
    has_many :products

    validates :categoryname, presence: true
    validates :categoryname, length: { minimum: 3, maximum: 50 }
end
