require 'rails_helper'

RSpec.describe 'merchant_employee', type: :feature do
  it 'can see what merchant they work for' do

    merchant = create(:merchant)
    employee = create(:merchant_employee, role: 1, merchant_id: merchant.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)

    visit '/merchant'
    
    within '#merchant-info' do
      expect(page).to have_content(merchant.name)
      expect(page).to have_content(merchant.address)
      expect(page).to have_content(merchant.state)
      expect(page).to have_content(merchant.zip)
    end
  end  

  it "sees pending orders" do
    @meg = create(:merchant)
    employee = create(:merchant_employee, role: 1, merchant_id: @meg.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)
  
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
  
    user = create(:regular_user)
    @order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
  

    @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "pending")
    @item_order_2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: "pending")
  
  
    visit "/merchant"


    expect(page).to have_link("Order ##{@order_1.id}") 
    expect(page).to have_content(@order_1.created_at) 
    expect(page).to have_content(@order_1.total_quantity) 
    expect(page).to have_content(@order_1.grandtotal)
    
  end  
end