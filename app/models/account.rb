class Account < ApplicationRecord
    validates :email, :password, :password_confirmation presence: true
    validates :password, confirmation: true
    validates :primarypostalcode, postal_code: true
    validates :secondarypostalcode, postal_code: true
end
