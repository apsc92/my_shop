class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: :true, numericality: { greater_than: 0 }


  def cost
    bundle_discount = BundleDiscount.where(targeted_product_id: self.product.id).first
    cost = self.product.price * self.quantity
    if bundle_discount
      bundles = quantity / bundle_discount.quantity_to_be_purchased
      if bundles > 0
        cost = bundle_discount.price_after_discount
        remainder = self.quantity % bundle_discount.quantity_to_be_purchased
        cost += remainder * self.product.price
      end
    end
    cost
  end
end
