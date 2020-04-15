require 'rails_helper'

RSpec.describe "As a merchant employee" do
  before(:each) do
    @merchant = create(:merchant)
    user = create(:merchant_employee)
    item1 = create(:item, merchant: @merchant)
    item2 = create(:item, merchant: @merchant)
    @order = user.orders.create!(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip)
    @item_order1 = @order.item_orders.create!(item: item1, price: item1.price, quantity: 1, status: "pending")
    @item_order2 = @order.item_orders.create!(item: item2, price: item2.price, quantity: 1, status: "pending")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/merchant/orders/#{@order.id}"
  end

  it "I can view an order show page" do
    expect(page).to have_content("Order ##{@order.id}")
    within('.shipping-address') do
      expect(page).to have_content("Shipping Info")
      expect(page).to have_content(@order.name)
      expect(page).to have_content(@order.address)
      expect(page).to have_content(@order.city)
      expect(page).to have_content(@order.state)
      expect(page).to have_content(@order.zip)
    end

    @order.item_orders.each do |item_order|
      within("#item-#{item_order.item_id}") do
        expect(page).to have_link(item_order.item.name, href: "/merchants/#{item_order.item.merchant_id}/items/#{item_order.item_id}")
        expect(page).to have_css("img[src*='#{item_order.item.image}']")
        expect(page).to have_content(item_order.price)
        expect(page).to have_content(item_order.quantity)
      end
    end
  end
end