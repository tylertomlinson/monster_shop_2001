require 'rails_helper'

RSpec.describe 'Logged in user show page', type: :feature do
  before(:each) do
    @user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'displays all profile data on the page except my password with a link to edit profile' do
    visit '/profile'

    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.address)
    expect(page).to have_content(@user.city)
    expect(page).to have_content(@user.state)
    expect(page).to have_content(@user.zip)
    expect(page).to have_content(@user.email)
    expect(page).to have_link("Edit Profile")
  end

  it 'displays orders link' do
    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)

    visit "/items/#{paper.id}"
    click_on "Add To Cart"
    visit "/cart"
    click_on "Checkout"

    name = "Bert"
    address = "123 Sesame St."
    city = "NYC"
    state = "New York"
    zip = 10001

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    click_button "Create Order"
    visit "/profile"
    click_link("My Orders")
    expect(current_path).to eq("/profiles/orders")
  end
end
