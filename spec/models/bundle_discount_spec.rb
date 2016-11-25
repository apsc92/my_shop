require 'rails_helper'

RSpec.describe BundleDiscount, type: :model do
  subject {
    described_class.new(quantity_to_be_purchased: 4, targeted_product_id: 1,
                      price_after_discount: 20)
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without quantity_to_be_purchased" do
      subject.quantity_to_be_purchased = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without price_after_discount" do
      subject.price_after_discount = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with negative quantity_to_be_purchased" do
      subject.quantity_to_be_purchased = -1
      expect(subject).to_not be_valid
    end

    it "is not valid with negative price_after_discount" do
      subject.price_after_discount = -1
      expect(subject).to_not be_valid
    end
  end


  describe "Associations" do
    it "has one product as targeted product" do
      assc = described_class.reflect_on_association(:product)
      expect(assc.macro).to eq :has_one
    end
  end
end
