class About < ApplicationRecord
    validates :title, :body, presence: true
end
