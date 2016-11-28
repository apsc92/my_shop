FactoryGirl.define do
  factory :promocode do
    name       Faker::Name.name
    promo_type 'percentage'
    percentage  '20'
    allowed_in_conjunction false
  end
end