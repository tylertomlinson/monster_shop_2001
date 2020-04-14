require 'rails_helper'

RSpec.describe "order fulfillment" do
  context "as a user" do
    before(:each) do
        @user = create(:regular_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
        # @order_2 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
        @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
        @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)
    end

    it "order status changes to packed once all items fulfilled by merchant" do

        visit "merchant/orders/#{@order_1.id}"

        expect(@order_1.status).to eq("Pending")

        within "#item-#{@tire.id}" do
            expect(page).to have_link("Fulfill Order")
        end

        within "#item-#{@chain.id}" do
            expect(page).to have_link("Fulfill Order")
        end

        expect(@order_1.status).to eq("Packaged") 
    end
  end
end


# When all items in an order have been "fulfilled" by their merchants
# The order status changes from "pending" to "packaged"