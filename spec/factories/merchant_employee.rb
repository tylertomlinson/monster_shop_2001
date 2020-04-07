FactoryBot.define do
  factory :merchant_user, class: User do
    name        { Faker::Name.name }
    address     { Faker::Address.street_address }
    city        { Faker::Address.city }
    state       { Faker::Address.state }
    zip         { "11111" }
    email       { Faker::Internet.email }
    password    { "password123" }
    role        { 1 }
  end
end
