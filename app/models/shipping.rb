class Shipping < ApplicationRecord
  belongs_to :order
  has_one :receiver_address
  accepts_nested_attributes_for :receiver_address
end
