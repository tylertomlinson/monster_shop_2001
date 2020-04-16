require 'rails_helper'

RSpec.describe 'As an admin', type: :feature do
  describe "user order show page view", type: :feature do
    it "can see all order/item info" do

      admin = create(:admin_user)
      user_1 = create(:regular_user)
      merchant = create(:merchant)

      item_1 = merchant.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      item_2 = merchant.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      order_1 = user_1.orders.create(name: "Daniel", address: "66 Highway", city: "Las Cruces", state: "NM", zip: 88888, status: "packaged")

      order_1.item_orders.create(item: item_1, price: item_1.price, quantity: 2)
      order_1.item_orders.create(item: item_2, price: item_2.price, quantity: 2)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/users/#{order_1.user.id}"

      click_link 'Orders'

      expect(current_path).to eq("/admin/users/#{order_1.user.id}/orders")

      click_on "#{order_1.id}"
      expect(current_path).to eq("/admin/users/#{order_1.user.id}/orders/#{order_1.id}")

      expect(page).to have_content(order_1.id)
      expect(page).to have_content(order_1.created_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(order_1.updated_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(order_1.status)

      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.description)

      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.description)
    end
  end
end
