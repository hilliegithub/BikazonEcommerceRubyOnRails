class Province < ApplicationRecord
  validates :provincename, presence: true
  validates :taxtype, presence: true
  validates :pst, numericality: { greater_than_or_equal_to: 0 }
  validates :gst, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, numericality: { greater_than_or_equal_to: 0 }
end
