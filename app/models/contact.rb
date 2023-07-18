class Contact < ApplicationRecord
    validates :phonenumber, :email, :openinghours, presence: true
    validates :phonenumber, format: { with: /\A(\+?1\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/, message: "Invalid phone number format" }
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Invalid email format" }
end
