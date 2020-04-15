require 'rails_helper'

RSpec.describe "As an Admin" do
  before(:each) do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant, active?: false)

    user = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/merchants'
  end

  it "I can visit the admin's merchant index page" do
    expect(page).to have_link("New Merchant")

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_link(@merchant1.name)
      expect(page).to have_content("Enabled")
      expect(page).to have_link("Disable Merchant")
    end

    within("#merchant-#{@merchant2.id}") do
      expect(page).to have_link(@merchant2.name)
      expect(page).to have_content("Enabled")
      expect(page).to have_link("Disable Merchant")
    end

    within("#merchant-#{@merchant3.id}") do
      expect(page).to have_link(@merchant3.name)
      expect(page).to have_content("Disabled")
      expect(page).to have_link("Enable Merchant")
    end
  end

  it "I can disable a merchant" do
    within("#merchant-#{@merchant1.id}") do
      click_link("Disable Merchant")
    end

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("The account for #{@merchant1.name} has been disabled")

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_content("Disabled")
      expect(page).to have_link("Enable Merchant")
    end
  end

  it "When I disable a merchant, its items are inactivated" do
    create(:item, merchant: @merchant1)
    create(:item, merchant: @merchant1)

    within("#merchant-#{@merchant1.id}") do
      click_link("Disable Merchant")
    end

    visit "/merchants/#{@merchant1.id}/items"

    @merchant1.items.each do |item|
      within("#item-#{item.id}") do
        expect(page).to have_content("Inactive")
      end
    end
  end

  it "I can enable a merchant" do
    within("#merchant-#{@merchant3.id}") do
      expect(page).to have_content("Disabled")
      click_link("Enable Merchant")
    end

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("The account for #{@merchant3.name} has been enabled")

    within("#merchant-#{@merchant3.id}") do
      expect(page).to have_content("Enabled")
      expect(page).to have_link("Disable Merchant")
    end
  end

  it "When I enable a merchant, its items are activated" do
    create(:item, merchant: @merchant1)
    create(:item, merchant: @merchant1)

    within("#merchant-#{@merchant1.id}") do
      click_link("Disable Merchant")
    end

    within("#merchant-#{@merchant1.id}") do
      click_link("Enable Merchant")
    end

    visit "/merchants/#{@merchant1.id}/items"

    @merchant1.items.each do |item|
      within("#item-#{item.id}") do
        expect(page).to have_content("Active")
      end
    end
  end

  it "I can see a merchant's information" do
    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_link(@merchant1.name, href: "/admin/merchants/#{@merchant1.id}")
      expect(page).to have_content(@merchant1.city)
      expect(page).to have_content(@merchant1.state)
      expect(page).to have_content("Enabled")
      expect(page).to have_link("Disable Merchant")
    end

    within("#merchant-#{@merchant3.id}") do
      expect(page).to have_link(@merchant3.name, href: "/admin/merchants/#{@merchant3.id}")
      expect(page).to have_content(@merchant3.city)
      expect(page).to have_content(@merchant3.state)
      expect(page).to have_content("Disabled")
      expect(page).to have_link("Enable Merchant")
    end
  end

  it "I see everything that merchant would see" do
    @tire = @merchant1.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @merchant1.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    user = create(:regular_user)
    @order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)


    @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    @item_order_2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)

    click_on(@merchant1.name)

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")


    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant1.address)
    expect(page).to have_content(@merchant1.state)
    expect(page).to have_content(@merchant1.zip)
    expect(page).to have_link("Order ##{@order_1.id}")
    expect(page).to have_content(@order_1.created_at)
    expect(page).to have_content(@order_1.total_quantity)
    expect(page).to have_content(@order_1.grandtotal)
  end
end