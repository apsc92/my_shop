require 'rails_helper'

RSpec.describe BundleDiscount, type: :model do
  before(:all) do
    @bundle_discount = create(:bundle_discount)
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(@bundle_discount).to be_valid
    end

    it "is not valid without quantity_to_be_purchased" do
      @bundle_discount.quantity_to_be_purchased = nil
      expect(@bundle_discount).to_not be_valid
    end

    it "is not valid without price_after_discount" do
      @bundle_discount.price_after_discount = nil
      expect(@bundle_discount).to_not be_valid
    end

    it "is not valid with negative quantity_to_be_purchased" do
      @bundle_discount.quantity_to_be_purchased = -1
      expect(@bundle_discount).to_not be_valid
    end

    it "is not valid with negative price_after_discount" do
      @bundle_discount.price_after_discount = -1
      expect(@bundle_discount).to_not be_valid
    end
  end


  describe "Associations" do
    it "has one product as targeted product" do
      assc = described_class.reflect_on_association(:product)
      expect(assc.macro).to eq :has_one
    end
  end
end
