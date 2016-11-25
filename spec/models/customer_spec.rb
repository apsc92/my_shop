require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject {
    described_class.new(name: "Anurag", email: 'anurag@joshsoftware.com')
  }

  describe "Validations" do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

  end

  describe "Associations" do
    it "has many credit_cards" do
      assc = described_class.reflect_on_association(:credit_cards)
      expect(assc.macro).to eq :has_many
    end

    it "has many orders" do
      assc = described_class.reflect_on_association(:orders)
      expect(assc.macro).to eq :has_many
    end
  end
end
