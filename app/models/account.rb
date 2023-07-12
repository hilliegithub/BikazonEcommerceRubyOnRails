class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    belongs_to :primary_province, class_name: 'Province', optional: true
    belongs_to :secondary_province, class_name: 'Province', optional: true
    has_many :orders
    has_many_attached :images

    validates :email, presence: true
    #validates :password, confirmation: true
    validates :primarypostalcode, postal_code: true
    validates :secondarypostalcode, postal_code: true
    #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
