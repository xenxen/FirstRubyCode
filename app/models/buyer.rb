class Buyer < ApplicationRecord
  belongs_to :order
  has_one :phone
  has_one :billing_info
  accepts_nested_attributes_for :phone, :billing_info
end
