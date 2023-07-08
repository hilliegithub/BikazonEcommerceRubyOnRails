class Account < ApplicationRecord
    belongs_to :primary_province, class_name: 'Province'
    belongs_to :secondary_province, class_name: 'Province'
    has_many :orders

    validates :email, :password, :password_confirmation presence: true
    validates :password, confirmation: true
    validates :primarypostalcode, postal_code: true
    validates :secondarypostalcode, postal_code: true
end
