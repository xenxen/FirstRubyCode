class Order < ApplicationRecord
    has_many :order_items
    has_many :payments
    accepts_nested_attributes_for :order_items, :payments
end
