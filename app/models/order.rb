class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :promocodes

  def add_item(product, quantity)
    existing_order_item = self.order_items.where(product: product).first
    if existing_order_item
      existing_order_item.quantity += quantity
      existing_order_item.save
    else
      item = self.order_items.new(quantity: quantity, product: product)
      item.save
    end

  end

  def has_items?
    order_items.present?
  end

  def total_items
    order_items.sum(:quantity)
  end

  def total_cost
    order_items.sum(&:cost)
  end
end
