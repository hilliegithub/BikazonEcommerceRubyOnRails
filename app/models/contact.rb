class Contact < ApplicationRecord
    validates :phonenumber, :email, :openinghours, presence: true
end
