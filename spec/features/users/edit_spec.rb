require 'rails_helper'

RSpec.describe 'Editing user profile', type: :feature do
  before(:each) do

    @user = create(:regular_user)
    @old_name = @user.name
    @old_state = @user.state
    @dup_email_user = create(:regular_user, email: 'alreadytaken@gmail.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'displays all profile data except password, which I am able to change' do

    visit '/profile'

    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.address)
    expect(page).to have_content(@user.city)
    expect(page).to have_content(@user.state)
    expect(page).to have_content(@user.zip)
    expect(page).to have_content(@user.email)

    click_link "Edit Profile"

    expect(current_path).to eq('/profile/edit')
    expect(page).to have_content("Edit Profile")

    fill_in :name, with: "Test Name"
    fill_in :address, with: "Test Address"
    fill_in :city, with: "Test City"
    fill_in :state, with: "Test State"
    fill_in :zip, with: "11111"
  
    click_on "Submit"

    expect(current_path).to eq('/profile')

    expect(page).to have_content("Your profile has been updated.")

    expect(page).to have_content(@user.name)
    expect(@user.address).to eq("Test Address")
    expect(page).to have_content(@user.city)
    expect(page).to have_content(@user.state)
    expect(page).to have_content(@user.zip)
    expect(page).to have_content(@user.email)

    expect(page).to_not have_content(@old_name)
    expect(page).to_not have_content(@old_state)
  end

  it "error message displaying which fields can't be blank" do

    visit '/profile'

    click_link "Edit Profile"

    fill_in :name, with: "Test Name"
    fill_in :address, with: "Test Address"
    fill_in :city, with: ""
    fill_in :state, with: "Test State"
    fill_in :zip, with: ""

    click_on "Submit"

    expect(page).to have_content("City can't be blank and Zip can't be blank")
  end

  it "error message displaying email has already been used" do

    visit '/profile'

    click_link "Edit Profile"

    fill_in :email, with: "alreadytaken@gmail.com"

    click_on "Submit"

    expect(page).to have_content("Email has already been taken")
  end
end
