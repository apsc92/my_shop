FactoryGirl.define do
  factory :order do
    after(:build) do |b|
      b.customer ||= FactoryGirl.create(:customer)
    end
  end
end