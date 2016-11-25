require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  customer = Customer.create(name: 'Anurag', email: 'anurag@joshsoftware.com')
  subject {
    described_class.new(owner_name: "Anurag", number: '1234', customer: customer)
  }

  describe "Validations" do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a owner_name" do
      subject.owner_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a number" do
      subject.number = nil
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it "belongs to customer" do
      assc = described_class.reflect_on_association(:customer)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
