FactoryGirl.define do
  factory :customer do
    name       Faker::Name.first_name
    email      Faker::Internet.email
  end
end