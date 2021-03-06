require 'rails_helper'

RSpec.describe "As a user" do
  before(:each) do
    user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    @order_2 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    @order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
    @order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2)
    visit "/profile/orders"
  end

  it "I can see all my orders at /profile/orders" do
    within("#order-#{@order_1.id}") do
      expect(page).to have_link("Order ##{@order_1.id}", href: "/profile/orders/#{@order_1.id}")
      expect(page).to have_content(@order_1.created_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(@order_1.updated_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(@order_1.status)
      expect(page).to have_content(@order_1.items.length)
      expect(page).to have_content("$#{@order_1.grandtotal}0")
    end

    within("#order-#{@order_2.id}") do
      expect(page).to have_link("Order ##{@order_2.id}", href: "/profile/orders/#{@order_2.id}")
      expect(page).to have_content(@order_2.created_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(@order_2.updated_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(@order_2.status)
      expect(page).to have_content(@order_2.items.length)
      expect(page).to have_content("$#{@order_2.grandtotal}0")
    end
  end
end