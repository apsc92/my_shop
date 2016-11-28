FactoryGirl.define do
  factory :bundle_discount do
    quantity_to_be_purchased  '3'
    price_after_discount 10
    after(:build) do |b|
      b.targeted_product_id ||= FactoryGirl.create(:product).id
    end
  end
end