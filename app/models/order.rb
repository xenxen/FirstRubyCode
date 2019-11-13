class Order < ApplicationRecord
    has_many :order_items
    has_many :payments
    has_one :shipping
    has_one :buyer
    accepts_nested_attributes_for :order_items, :payments, :shipping, :buyer
end
