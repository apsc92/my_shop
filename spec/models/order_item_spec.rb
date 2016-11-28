require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe "Validations" do
    before(:all) do
      @order_item = create(:order_item)
    end

    it "is valid with valid attributes" do
      expect(@order_item).to be_valid
    end

    it "is not valid without a quantity" do
      @order_item.quantity = nil
      expect(@order_item).to_not be_valid
    end

  end

  describe "Associations" do
    it "has many credit_cards" do
      assc = described_class.reflect_on_association(:product)
      expect(assc.macro).to eq :belongs_to
    end

    it "has many orders" do
      assc = described_class.reflect_on_association(:order)
      expect(assc.macro).to eq :belongs_to
    end
  end

  describe "Cost calculation" do

    it "should show total price if no bundle discount applicable" do
      @order_item = create(:order_item)
      expect(@order_item.cost).to eq(@order_item.product.price * @order_item.quantity)
    end

    it "show consider bundle discount too if applicable" do
      @order_item = create(:order_item, quantity: 3)
      @bundle_discount = BundleDiscount.create(targeted_product_id: @order_item.product.id, quantity_to_be_purchased: 3, price_after_discount: 10)
      expect(@order_item.cost).to eq(@bundle_discount.price_after_discount)
    end
  end
end
