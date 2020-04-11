require 'rails_helper'

RSpec.describe "As a user" do
  before(:each) do
    user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "fulfilled")
    @item_order_2 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 4, status: "unfulfilled")
    visit "/profile/orders"
  end

  it "I can see an order" do
    click_link "Order ##{@order_1.id}"
    expect(current_path).to eq("/profile/orders/#{@order_1.id}")
    expect(page).to have_content("Order ##{@order_1.id}")
    expect(page).to have_content("Date created: #{@order_1.created_at}")
    expect(page).to have_content("Date updated: #{@order_1.updated_at}")
    expect(page).to have_content("Status: #{@order_1.status}")

    @order_1.item_orders.each do |item_order|
      within("#item_order-#{item_order.item.id}") do
        expect(page).to have_content("Name: #{item_order.item.name}")
        expect(page).to have_content("Description: #{item_order.item.description}")
        expect(page).to have_css("img[src*='#{item_order.item.image}']")
        expect(page).to have_content("Quantity: #{item_order.quantity}")
        expect(page).to have_content("Price: $#{item_order.item.price}.00")
        expect(page).to have_content("Subtotal: $#{item_order.subtotal}0")
      end
    end

    expect(page).to have_content("Total quantity: #{@order_1.total_quantity}")
    expect(page).to have_content("Grand total: $#{@order_1.grandtotal}0")
  end

  it "I can cancel an order" do
    expect(@order_1.status).to eq("pending")
    expect(@item_order_1.status).to eq("fulfilled")
    expect(@tire.inventory).to eq(12)
    expect(@chain.inventory).to eq(5)

    click_link "Order ##{@order_1.id}"
    click_link "Cancel Order"

    @order_1.reload
    @item_order_1.reload
    @item_order_2.reload
    @tire.reload
    @chain.reload

    expect(@order_1.status).to eq("cancelled")
    @order_1.item_orders.each do |item_order|
      expect(item_order.status).to eq("unfulfilled")
    end
    expect(@tire.inventory).to eq(14)
    expect(@chain.inventory).to eq(5)
    expect(current_path).to eq("/profile")
    expect(page).to have_content("Order ##{@order_1.id} has been cancelled")

    visit profile_order_path(@order_1)

    expect(page).to have_content("Status: cancelled")
  end
end

