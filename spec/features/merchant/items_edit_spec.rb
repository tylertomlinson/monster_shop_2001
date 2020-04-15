require 'rails_helper'

RSpec.describe "As a Merchant" do
  describe "When I visit the merchant items page" do
    describe "and click on edit item, which is prepopulated" do
      before(:each) do
        @merchant = create(:merchant)
        @tire = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @merchant_employee = create(:merchant_employee, merchant_id: @merchant.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)

        visit "/merchants/#{@merchant.id}/items"

        click_on "Edit Item"
      end

      it "fields are prepopulated" do
        expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")

        expect(find_field('Name').value).to eq "Gatorskins"
        expect(find_field('Price').value).to eq '$100.00'
        expect(find_field('Description').value).to eq "They'll never pop!"
        expect(find_field('Image').value).to eq("https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588")
        expect(find_field('Inventory').value).to eq '12'
      end

      it "can change and update item with the form" do

        fill_in 'Name', with: "Test Edit Name"
        fill_in 'Price', with: 1000
        fill_in 'Description', with: "Test Description"
        fill_in 'Image', with: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588"
        fill_in 'Inventory', with: 1001

        click_button "Update Item"

        expect(current_path).to eq("/merchants/#{@merchant.id}/items")

        expect(page).to have_content("Test Edit Name")
        expect(page).to have_content("Test Edit Description")

        expect(page).to_not have_content("They'll never pop!")
        expect(page).to_not have_content("Gatorskins")
      end

      it "I get a flash message if entire form is not filled out" do

        fill_in 'Name', with: ""
        fill_in 'Price', with: 110
        fill_in 'Description', with: "Test Description"
        fill_in 'Inventory', with: 11

        click_button "Update Item"

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_button("Update Item")
      end
    end
  end
end
