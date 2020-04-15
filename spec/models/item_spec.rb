require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end


  describe "instance methods" do
    before(:each) do
      @user1 = create(:regular_user)
      @user2 = create(:regular_user)
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @dog_bone = @bike_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?: false, inventory: 21)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      user = create(:regular_user)
      order = user.orders.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end

    it "most and least popular items" do

      most_popular = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 10000)
      least_popular = @bike_shop.items.create!(name: 'Chain2', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 10000)
      item3 = @bike_shop.items.create!(name: 'Chain3', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 10000)
      item4 = @bike_shop.items.create!(name: 'Chain4', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 10000)
      item5 = @bike_shop.items.create!(name: 'Chain5', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 10000)

      order1 = @user1.orders.create!(name: 'Test Name', address: '123 Test', city: 'Test City', state: 'Test State', zip: 10000)
      order2 = @user2.orders.create!(name: 'Test Name2', address: '1234 Test', city: 'Test City2', state: 'Test State2', zip: 10000)

      item_order1_info = { order_id: order1.id, item_id: most_popular.id, price: most_popular.price, quantity: 700 }
      ItemOrder.create!(item_order1_info)

      item_order2_info = { order_id: order2.id, item_id: least_popular.id, price: least_popular.price, quantity: 3 }
      ItemOrder.create!(item_order2_info)

      item_order3_info = { order_id: order1.id, item_id: item3.id, price: item3.price, quantity: 40 }
      ItemOrder.create!(item_order3_info)

      item_order4_info = { order_id: order2.id, item_id: item4.id, price: item4.price, quantity: 35 }
      ItemOrder.create!(item_order4_info)

      item_order5_info = { order_id: order1.id, item_id: item5.id, price: item5.price, quantity: 50 }
      ItemOrder.create!(item_order5_info)

      expect([Item.most_popular(5)[0].name, Item.most_popular(5)[1].name, Item.most_popular(5)[2].name, Item.most_popular(5)[3].name, Item.most_popular(5)[4].name]).to eq([most_popular.name, item5.name, item3.name, item4.name, least_popular.name])

      expect([Item.least_popular(5)[0].name, Item.least_popular(5)[1].name, Item.least_popular(5)[2].name, Item.least_popular(5)[3].name, Item.least_popular(5)[4].name]).to eq([least_popular.name, item4.name, item3.name, item5.name, most_popular.name])
    end

    it "can find all active items" do
      expected = Item.active_items
      expect(expected.count).to eq(1)
    end

    it "quantity ordered" do
      item_1 = @bike_shop.items.create!(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 10)
      item_2 = @bike_shop.items.create!(name: 'Chain2', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 15)
      item_3 = @bike_shop.items.create!(name: 'Chain3', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 20)
      item_4 = @bike_shop.items.create!(name: 'Chain4', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 50)
      item_5 = @bike_shop.items.create!(name: 'Chain5', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 25)
      item_6 = @bike_shop.items.create!(name: 'Chain6', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 30)
      item_7 = @bike_shop.items.create!(name: 'Chain7', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 55)

      order1 = @user1.orders.create!(name: 'Test Name', address: '123 Test', city: 'Test City', state: 'Test State', zip: 10000)
      order2 = @user2.orders.create!(name: 'Test Name2', address: '1234 Test', city: 'Test City2', state: 'Test State2', zip: 10000)

      item_order1_info = { order_id: order1.id, item_id: item_1.id, price: item_1.price, quantity: 35 }
      ItemOrder.create!(item_order1_info)

      item_order2_info = { order_id: order2.id, item_id: item_2.id, price: item_2.price, quantity: 60 }
      ItemOrder.create!(item_order2_info)

      item_order3_info = { order_id: order1.id, item_id: item_3.id, price: item_3.price, quantity: 40 }
      ItemOrder.create!(item_order3_info)

      item_order4_info = { order_id: order2.id, item_id: item_4.id, price: item_4.price, quantity: 35 }
      ItemOrder.create!(item_order4_info)

      item_order5_info = { order_id: order1.id, item_id: item_5.id, price: item_5.price, quantity: 50 }
      ItemOrder.create!(item_order5_info)

      item_order6_info = { order_id: order2.id, item_id: item_6.id, price: item_6.price, quantity: 20 }
      ItemOrder.create!(item_order6_info)

      item_order7_info = {order_id: order1.id, item_id: item_7.id, price: item_7.price, quantity: 10 }
      ItemOrder.create!(item_order7_info)

      item_order8_info = {order_id: order2.id, item_id: item_1.id, price: item_1.price, quantity: 20 }
      ItemOrder.create!(item_order8_info)

      expect(item_1.quantity_ordered).to eq(55)
      expect(item_2.quantity_ordered).to eq(60)
      expect(item_3.quantity_ordered).to eq(40)
      expect(item_4.quantity_ordered).to eq(35)
      expect(item_5.quantity_ordered).to eq(50)
      expect(item_6.quantity_ordered).to eq(20)
      expect(item_7.quantity_ordered).to eq(10)
    end

    it "update_status" do
      @chain.update_status
      @chain.reload

      expect(@chain.active?).to eq(false)

      @chain.update_status
      @chain.reload

      expect(@chain.active?).to eq(true)
    end
 end
end
