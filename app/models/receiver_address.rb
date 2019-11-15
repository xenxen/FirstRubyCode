class ReceiverAddress < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :neighborhood
  belongs_to :shipping
  accepts_nested_attributes_for :city, :state, :country, :neighborhood, :shipping
end
