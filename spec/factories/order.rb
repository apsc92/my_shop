FactoryGirl.define do
  factory :order do
    status 'building'
    after(:build) do |b|
      b.customer ||= FactoryGirl.create(:customer)
    end
  end
end