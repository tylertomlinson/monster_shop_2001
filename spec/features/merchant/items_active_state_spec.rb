require 'rails_helper'

RSpec.describe "Merchant employee", type: :feature do
  it "can see item info and deactivate items" do

    merchant1 = create(:merchant)
    user1 = create(:merchant_employee)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit "/merchants/#{merchant1.id}/items"

    within "#item-#{item1.id}" do
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.price)
      expect(page).to have_css("img[src*='#{item1.image}']")
      expect(page).to have_content("Active")
      expect(page).to have_content(item1.inventory)

      expect(page).to_not have_content(item2.name)
    end

    within "#item-#{item2.id}" do
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item2.description)
      expect(page).to have_content(item2.price)
      expect(page).to have_css("img[src*='#{item2.image}']")
      expect(page).to have_content("Active")
      expect(page).to have_content(item2.inventory)

      expect(page).to_not have_content(item1.name)
    end

    within "#item-#{item1.id}" do
      click_link "Deactivate"
    end

    item1.reload

    expect(current_path).to eq("/merchants/#{merchant1.id}/items")
    expect(page).to have_content("#{item1.name} is no longer for sale.")
    expect(item1.active?).to eq(false)

    expect(page).to_not have_content("#{item1.name} is now available for sale.")

    within "#item-#{item2.id}" do
      click_link "Deactivate"
    end

    item2.reload

    expect(current_path).to eq("/merchants/#{merchant1.id}/items")
    expect(page).to have_content("#{item2.name} is no longer for sale.")
    expect(item1.active?).to eq(false)

    expect(page).to_not have_content("#{item2.name} is now available for sale.")
  end

  it "can see item info and activate items" do

    merchant2 = create(:merchant)
    user2 = create(:merchant_employee, merchant: merchant2)
    item3 = create(:item, active?: false, merchant: merchant2)
    item4 = create(:item, active?: false, merchant: merchant2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit "/merchants/#{merchant2.id}/items"

    within "#item-#{item3.id}" do
      expect(page).to have_content(item3.name)
      expect(page).to have_content(item3.description)
      expect(page).to have_content(item3.price)
      expect(page).to have_css("img[src*='#{item3.image}']")
      expect(page).to have_content("Inactive")
      expect(page).to have_content(item3.inventory)

      expect(page).to_not have_content(item4.name)

    end

    within "#item-#{item4.id}" do
      expect(page).to have_content(item4.name)
      expect(page).to have_content(item4.description)
      expect(page).to have_content(item4.price)
      expect(page).to have_css("img[src*='#{item4.image}']")
      expect(page).to have_content("Inactive")
      expect(page).to have_content(item4.inventory)

      expect(page).to_not have_content(item3.name)
    end

    within "#item-#{item3.id}" do
      click_link "Activate"
    end

    item3.reload

    expect(current_path).to eq("/merchants/#{merchant2.id}/items")
    expect(page).to have_content("#{item3.name} is now available for sale.")

    expect(page).to_not have_content("#{item3.name} is no longer for sale.")

    within "#item-#{item3.id}" do
      expect(page).to have_content("Active")
      expect(item3.active?).to eq(true)
    end

    within "#item-#{item4.id}" do
      click_link "Activate"
    end

    item4.reload

    expect(current_path).to eq("/merchants/#{merchant2.id}/items")
    expect(page).to have_content("#{item4.name} is now available for sale.")

    expect(page).to_not have_content("#{item4.name} is no longer for sale.")

    within "#item-#{item4.id}" do
      expect(page).to have_content("Active")
      expect(item4.active?).to eq(true)
    end
  end
end
