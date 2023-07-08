class Category < ApplicationRecord
    validates :categoryname, presence: true
end
