require "rails_helper"

RSpec.describe 'Editing user password' do
  describe "can see a link to edit my password" do
    it "fill both fields with same password and redirect to profile displaying success flash message" do

      user = create(:regular_user)
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/profile'

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.email)

      click_link "Edit Password"

      expect(current_path).to eq('/profile/edit_password')

      fill_in :password, with: "testpassword"
      fill_in :password_confirmation, with: "testpassword"

      click_on "Submit"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Your password has been updated.")
    end

    it "will return error when passwords are not the same" do

      user = create(:regular_user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/profile'

      click_link "Edit Password"

      fill_in :password, with: "testpassword1"
      fill_in :password_confirmation, with: "testpassword"

      click_on "Submit"

      expect(current_path).to eq('/profile/edit_password')
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
