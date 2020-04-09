FactoryBot.define do
  factory :merchant, class: Merchant do
    name     { Faker::Name.name }
    address  { Faker::Address.street_address }
    city     { Faker::Address.city }
    state    { Faker::Address.state }
    zip      { "11111" }
  end
end
