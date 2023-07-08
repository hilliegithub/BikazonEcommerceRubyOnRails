class Category < ApplicationRecord
    has_many :products

    validates :categoryname, presence: true
end
