class Province < ApplicationRecord
  has_many :primary_accounts, class_name: 'Account', foreign_key: 'primary_province_id'
  has_many :secondary_accounts, class_name: 'Account', foreign_key: 'secondary_province_id'

  validates :provincename, presence: true
  validates :taxtype, presence: true
  validates :pst, numericality: { greater_than_or_equal_to: 0 }
  validates :gst, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, numericality: { greater_than_or_equal_to: 0 }
end
