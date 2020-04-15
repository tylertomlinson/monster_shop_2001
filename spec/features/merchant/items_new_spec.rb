require 'rails_helper'

RSpec.describe 'As a merchant', type: :feature do
  describe 'When I visit my items page' do
    before(:each) do
      @merchant = create(:merchant)
      @merchant_employee = create(:merchant_employee, merchant: @merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
      @item = create(:item, merchant: @merchant)
    end

    it "can see a link to add a new item" do
      visit "/merchant/items"

      expect(page).to have_link('Add New Item')

      click_link('Add New Item')
      expect(current_path).to eq("/merchant/items/new")
    end

    it "can see a form for creating item" do

      visit "/merchant/items/new"

      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Image')
      expect(page).to have_field('Price')
      expect(page).to have_field('Inventory')
    end

    it "can enter new item info" do

      visit "/merchant/items/new"

      fill_in 'Name', with: 'Test Name'
      fill_in 'Description', with: 'Test Description'
      fill_in 'Image', with: "https://images-na.ssl-images-amazon.com/images/I/61DyNlPnnqL._AC_SL1500_.jpg"
      fill_in 'Price', with: 100
      fill_in 'Inventory', with: 200

      click_on 'Create Item'

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_content("Test Name has been created.")
    end

    it 'I see the new item on the page, and it is enabled and available for sale' do
      visit "/merchant/items"

      expect(page).to have_link(@item.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.inventory)
      expect(page).to have_content('Active')
    end

    it "returns flash message with missing fields" do

      visit "/merchant/items/new"

      fill_in 'Name', with: ''
      fill_in 'Description', with: 'Test Description'
      fill_in 'Image', with: "https://images-na.ssl-images-amazon.com/images/I/61DyNlPnnqL._AC_SL1500_.jpg"
      fill_in 'Price', with: 100
      fill_in 'Inventory', with: 200

      click_on 'Create Item'

      expect(current_path).to eq("/merchant/items")
      expect(page).to have_content("Name can't be blank")
    end

    it 'image field has a default image placeholder' do

      visit "/merchant/items/new"

      fill_in 'Name', with: @item.name
      fill_in 'Description', with: @item.description
      fill_in 'Image', with: ""
      fill_in 'Price', with: @item.price
      fill_in 'Inventory', with: @item.inventory

      click_on 'Create Item'

      expect(current_path).to eq("/merchant/items")

      expect(page).to have_content("#{@item.name} has been created.")
    end
  end
end
