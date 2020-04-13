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
end