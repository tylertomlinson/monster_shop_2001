require 'rails_helper'

RSpec.describe "As a user" do
  it "I can see all my orders at /profile/orders" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    order_2 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
    item_order_2 = order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2)

    visit "/profile/orders"

    expect(page).to have_link("Order ##{order_1.idea}", href: "/profile/orders/#{order.id}")
    expect(page).to have_content("Date created: #{order.created_at}")
    expect(page).to have_content("Date updated: #{order.updated_at}")
    expect(page).to have_content("Status: #{order.status}")
    expect(page).to have_content("Item quantity: #{order.items.length}")
    expect(page).to have_content("Grand total: #{order.grandtotal}")
  end
end