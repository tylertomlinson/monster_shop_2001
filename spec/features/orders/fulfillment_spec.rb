require 'rails_helper'

RSpec.describe "order fulfillment" do
  context "as a user" do
    before(:each) do
        @user = create(:regular_user)
        @merchant = create(:merchant_employee)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
        @item_order1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
        @item_order2 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)
    end

    it "order status changes to packed once all items fulfilled by merchant" do

        visit "/merchant/orders/#{@order_1.id}"

        expect(page).to have_content("Status: #{@order_1.status}")

        within "#item-#{@item_order1.item_id}" do
            expect(page).to have_link("fulfill item")
            click_link "fulfill item"
        end

        within "#item-#{@item_order2.item_id}" do
            expect(page).to have_link("fulfill item")
            click_link "fulfill item"
        end

        expect(current_path).to eq("/merchant/orders/#{@order_1.id}")
        @order_1.reload
        expect(page).to have_content("packaged")
        expect(page).to have_content("Status: #{@order_1.status}")
    end
  end
end
