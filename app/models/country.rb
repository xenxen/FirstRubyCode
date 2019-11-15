class Country < ApplicationRecord
    has_many :receiver_address
    accepts_nested_attributes_for :receiver_address
end
