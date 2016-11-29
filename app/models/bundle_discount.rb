class BundleDiscount < ApplicationRecord
  has_one :product, as: :targeted_product
  validates :quantity_to_be_purchased, :price_after_discount, presence: :true, numericality: { greater_than: 0 }

  def offer_statement
    targeted_product = Product.find(targeted_product_id)
    self.quantity_to_be_purchased.to_s + ' ' + targeted_product.name + ' for £' + self.price_after_discount.to_s
  end
end
