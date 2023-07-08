class Account < ApplicationRecord
    belongs_to :primary_province, class_name: 'Province'
    belongs_to :secondary_province, class_name: 'Province'
    has_many :orders
    has_many_attached :images

    validates :email, :password, :password_confirmation, presence: true
    validates :password, confirmation: true
    validates :primarypostalcode, postal_code: true
    validates :secondarypostalcode, postal_code: true
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
