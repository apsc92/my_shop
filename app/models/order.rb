class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  before_validation do
    if self.status == 'building' && self.customer.nil?
      # Dummy Customer
      customer = Customer.find_or_create_by(name: 'customer1', email: 'customer1@gmail.com')
      self.customer = customer
      self.save
    end
  end

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

  def confirm
    self.status = 'confirmed'
    self.save
  end

  def has_items?
    order_items.present?
  end

  def total_items
    order_items.sum(:quantity)
  end

  def total_cost
    cost = order_items.sum(&:cost)
    # apply procomode if any
    applied_promos = Promocode.where(id: self.applied_promo_ids)
    if applied_promos.exists?
      applied_promos.each do |promo|
        if promo.promo_type == 'percentage'
          cost -= (cost * promo.percentage) / 100
        else
          cost -= promo.flat_discount
        end
      end
    end
    cost.round(2)
  end
end
