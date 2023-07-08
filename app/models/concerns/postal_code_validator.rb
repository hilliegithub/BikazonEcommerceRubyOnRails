require 'active_model'

class PostalCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    pattern = /\A[ABCEGHJKLMNPRSTVXY]\d[A-Z] \d[A-Z]\d\z/
    unless value =~ pattern
      record.errors.add(attribute, :invalid, message: 'is not a valid Canadian postal code')
    end
  end
end
