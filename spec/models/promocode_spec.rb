require 'rails_helper'

RSpec.describe Promocode, type: :model do
  subject {
    described_class.new(name: "Promocode1", percentage: 5)
  }

  describe "Validations" do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "get default type as percentage" do
      expect(subject.promo_type).to eq('percentage')
    end

    it "is allowed to be used in conjunction as default" do
      expect(subject.allowed_in_conjunction).to eq(true)
    end
  end
end
