FactoryGirl.define do
  factory :order_item do
    quantity  '2'
    after(:build) do |b|
      b.order ||= FactoryGirl.create(:order)
      b.product ||= FactoryGirl.create(:product)
    end
  end
end