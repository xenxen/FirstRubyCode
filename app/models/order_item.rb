class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :item
  accepts_nested_attributes_for :item
end
