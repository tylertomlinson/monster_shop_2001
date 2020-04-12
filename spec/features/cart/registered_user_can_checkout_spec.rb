require 'rails_helper'

describe 'As a registered user' do 
  describe "When I add items to my cart" do 
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      @items_in_cart = [@paper,@tire,@pencil]
      
      user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    
    it "And I click the button or link to check out and fill out order info and click create order" do 

      visit "/cart"

      expect(page).to have_link("Checkout")

      click_on "Checkout"

      expect(current_path).to eq("/orders/new")

      fill_in :name,	with: "Mike Dao" 
      fill_in :address,	with: "123 Test Street" 
      fill_in :city,	with: "Denver" 
      fill_in :state,	with: "Colorado" 
      fill_in :zip,	with: "80234"
      click_on 'Create Order'
      
      expect(current_path).to  eq("/profile/orders")
      expect(page).to have_content("Your order has been made!") 
      expect(page).to have_link("Order ##{Order.first.id}") 
      visit "/cart"
      expect(page).to_not have_css(".cart-items")
      expect(page).to have_content("Cart is currently empty")
    end
  end
end