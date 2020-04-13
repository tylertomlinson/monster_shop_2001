require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all active items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to have_link(@dog_bone.merchant.name)

      expect(page).to_not have_link(@dog_bone.name)
    end

    it "all active items images are links to item show page" do
     visit '/items'

     expect(page).to have_link("img-#{@tire.id}")
     expect(page).to have_link("img-#{@pull_toy.id}")
     click_link("img-#{@pull_toy.id}")
     expect(current_path).to eq("/items/#{@pull_toy.id}")
   end

    it "I can see a list of all active items "do
      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

        expect(page).to_not have_link(@dog_bone.name)
        expect(page).to_not have_content(@dog_bone.description)
        expect(page).to_not have_content("Price: $#{@dog_bone.price}")
        expect(page).to_not have_content("Inactive")
        expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    it "can find all active items" do
      expected = Item.active_items
      expect(expected.count).to eq(8)
    end

    describe 'Area with statistics:' do
      before(:each) do

        @user1 = create(:regular_user)
        @user2 = create(:regular_user)
        @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @item1 = @bike_shop.items.create!name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 1000
        @item2 = @bike_shop.items.create!name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 1000
        @item3 = @bike_shop.items.create!name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 1000
        @item4 = @bike_shop.items.create!name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 1000
        @item5 = @bike_shop.items.create!name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 1000

        @order1 = @user1.orders.create!(name: 'Test Name', address: '123 Test', city: 'Test City', state: 'Test State', zip: 10000)

        @item_order1_info = { order_id: @order1.id, item_id: @item1.id, price: @item1.price, quantity: 35 }
        ItemOrder.create!(@item_order1_info)

        @item_order2_info = { order_id: @order1.id, item_id: @item2.id, price: @item2.price, quantity: 60 }
        ItemOrder.create!(@item_order2_info)

        @item_order3_info = { order_id: @order1.id, item_id: @item3.id, price: @item3.price, quantity: 40 }
        ItemOrder.create!(@item_order3_info)

        @item_order4_info = { order_id: @order1.id, item_id: @item4.id, price: @item4.price, quantity: 35 }
        ItemOrder.create!(@item_order4_info)

        @item_order5_info = { order_id: @order1.id, item_id: @item5.id, price: @item5.price, quantity: 50 }
        ItemOrder.create!(@item_order5_info)
      end

      it "5 most popular items with quantity ordered" do

        visit '/items'

        within '#most-popular-items' do
          expect(page).to have_link(@item1.name)
          expect(page).to have_content(@item1.quantity_ordered)
          expect(page).to have_link(@item2.name)
          expect(page).to have_content(@item2.quantity_ordered)
          expect(page).to have_link(@item3.name)
          expect(page).to have_content(@item3.quantity_ordered)
          expect(page).to have_link(@item4.name)
          expect(page).to have_content(@item4.quantity_ordered)
          expect(page).to have_link(@item5.name)
          expect(page).to have_content(@item5.quantity_ordered)
        end
      end
    end
  end
end
