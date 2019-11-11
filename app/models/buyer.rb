class Buyer < ApplicationRecord
  belongs_to :phone
  belongs_to :billing_info
end
