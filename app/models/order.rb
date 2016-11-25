class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_one :address, dependent: :destroy

  private

  def total_items
    order_items.sum(:quantity)
  end

  def total_cost
    order_items.sum(:cost)
  end
end
