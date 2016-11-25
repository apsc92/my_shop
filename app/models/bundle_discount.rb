class BundleDiscount < ApplicationRecord
  has_one :product, as: :targeted_product
  validates :quantity_to_be_purchased, :price_after_discount, presence: :true, numericality: { greater_than: 0 }
end
