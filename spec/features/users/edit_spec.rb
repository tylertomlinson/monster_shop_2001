require 'rails_helper'

RSpec.describe 'Editing user profile', type: :feature do
  it 'displays all profile data except password, which I am able to change' do

      user = create(:regular_user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/profile'

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.email)

      click_link "Edit Profile"

      expect(current_path).to eq('/profile/edit')
      expect(page).to have_content("Edit Profile")

      fill_in :address, with: "Test Address"
      fill_in :city, with: "Test City"
      fill_in :state, with: "Test State"
      fill_in :zip, with: "11111"
      fill_in :password, with: "testpassword"
      fill_in :password_confirmation, with: "testpassword"

      click_on "Submit"

      user2 = User.last

      expect(current_path).to eq("/profile")

      expect(page).to have_content("Your profile has been updated.")

      expect(page).to have_content(user2.name)
      expect(page).to have_content(user2.address)
      expect(page).to have_content(user2.city)
      expect(page).to have_content(user2.state)
      expect(page).to have_content(user2.zip)
      expect(page).to have_content(user2.email)

      expect(page).to_not have_content(user.name)
      expect(page).to_not have_content(user.address)
      expect(page).to_not have_content(user.city)
      expect(page).to_not have_content(user.state)
      expect(page).to_not have_content(user.zip)
      expect(page).to_not have_content(user.email)
    end
end
