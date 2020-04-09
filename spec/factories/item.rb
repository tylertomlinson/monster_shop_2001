FactoryBot.define do
  factory :item, class: Item do
    name        { Faker::Name.name}
    description { Faker::ChuckNorris.fact }
    price       { Faker::Commerce.price}
    image       { Faker::Avatar.image }
    active?     {true}
    inventory   { Faker::Number.between(from: 1, to: 500)}
    association :merchant, factory: :merchant
  end
end
