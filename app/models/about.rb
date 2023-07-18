class About < ApplicationRecord
    validates :title, :body, presence: true
    validates :title, length: { minimum: 3, maximum: 50 }
    validates :body, length: { minimum: 5}
end
