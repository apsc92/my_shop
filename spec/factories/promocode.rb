FactoryGirl.define do
  factory :promocode do
    sequence(:name)       { |n| "promo#{n}" }
    promo_type 'percentage'
    percentage  '20'
    allowed_in_conjunction false
  end
end