require 'rails_helper'

RSpec.describe "admin dashboard page" do
  context "as an admin" do
    before: :each do 
        @user = create(:regular_user)
        @admin = create(:admin_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
        @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        @helmet = @meg.items.create(name: "Helmet", description: "Protect your brains", price: 50, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 10)

        @order1 = @user.orders.create(name: "Daniel", address: "66 Highway", city: "Las Cruces", state: "NM", zip: 88888, status: 1)
        @order1.item_orders.create(item: @tire, price: @tire.price, quantity: 2)

        @order2 = @user.orders.create(name: "Daniel", address: "66 Highway", city: "Las Cruces", state: "NM", zip: 88888, status: 0)
        @order2.item_orders.create(item: @paper, price: @paper.price, quantity: 1)

        @order3 = @user.orders.create(name: "Daniel", address: "66 Highway", city: "Las Cruces", state: "NM", zip: 88888, status: 2)
        @order3.item_orders.create(item: @pencil, price: @pencil.price, quantity: 3)

        @order4 = @user.orders.create(name: "Daniel", address: "66 Highway", city: "Las Cruces", state: "NM", zip: 88888, status: 3)
        @order4.item_orders.create(item: @helmet, price: @helmet.price, quantity: 6)

    end

    it "can see all orders in the system with user with link to profile, order id, and when created" do
      
        visit admin_path

        within "#order-#{@order1.id}"
            expect(page).to have_link("#{@order1.user.name}") 
            expect(page).to have_content(@order1.id)
            expect(page).to have_content("Date created: #{@order1.created_at.strftime("%m/%d/%Y")}")
            expect(page).to have_content("Packaged") 
        end

        within "#order-#{@order2.id}"
            expect(page).to have_link("#{@order2.user.name}") 
            expect(page).to have_content(@order2.id)
            expect(page).to have_content("Date created: #{@order2.created_at.strftime("%m/%d/%Y")}")
            expect(page).to have_content("Pending") 
        end

        within "#order-#{@order3.id}"
            expect(page).to have_link("#{@order3.user.name}") 
            expect(page).to have_content(@order3.id)
            expect(page).to have_content("Date created: #{@order3.created_at.strftime("%m/%d/%Y")}")
            expect(page).to have_content("Shipped") 
        end

        within "#order-#{@order4.id}"
            expect(page).to have_link("#{@order4.user.name}") 
            expect(page).to have_content(@order4.id)
            expect(page).to have_content("Date created: #{@order4.created_at.strftime("%m/%d/%Y")}")
            expect(page).to have_content("Cancelled") 
        end
    end

    it "can ship an order" do
        
        visit admin_path

        within "#order-#{@order1.id}"
            expect(page).to have_link("#{@order1.user.name}") 
            expect(page).to have_content(@order1.id)
            expect(page).to have_content("Date created: #{@order2.created_at.strftime("%m/%d/%Y")}")
            expect(page).to have_content("Packaged") 
            expect(page).to have_link("Ship Order") 
            click_link "Ship Order"
            expect(page).to not_have_content("Cancel") 
            expect(@order1.status).to eq("Shipped") 
        end

    end
    
  end
end

# User Story 32, Admin can see all orders

# As an admin user
# When I visit my admin dashboard ("/admin")
# Then I see all orders in the system.
# For each order I see the following information:

# - user who placed the order, which links to admin view of user profile
# - order id
# - date the order was created

# Orders are sorted by "status" in this order:

# - packaged
# - pending
# - shipped
# - cancelled