class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :product, as: :ordered_item
end
