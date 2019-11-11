class ReceiverAddress < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :country
  belongs_to :neighborhood
end
