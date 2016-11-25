class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :product, as: :ordered_item
  validates :quantity, presence: :true, numericality: { greater_than: 0 }
end
