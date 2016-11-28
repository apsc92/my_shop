FactoryGirl.define do
  factory :product do
    name       Faker::Name.first_name
    price      '123'
  end
end