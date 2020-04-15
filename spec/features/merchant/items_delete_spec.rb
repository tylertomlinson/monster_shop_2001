require 'rails_helper'

RSpec.describe "Merchant employee", type: :feature do
  it "can delete specific item" do

    user = create(:merchant_employee)
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchants/#{merchant.id}/items"

    within "#item-#{item1.id}" do
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.price)
      expect(page).to have_css("img[src*='#{item1.image}']")
      expect(page).to have_content("Active")
      expect(page).to have_content(item1.inventory)
    end

    click_on "Delete"

    expect(current_path).to eq("/merchants/#{merchant.id}/items")
    expect(page).to have_content("Item Successfully Deleted.")
    expect(page).to_not have_content(item1.name)
  end
end
