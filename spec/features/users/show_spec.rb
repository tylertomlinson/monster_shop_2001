require 'rails_helper'

RSpec.describe 'Logged in user show page', type: :feature do
  it 'displays all profile data on the page except my password with a link to edit profile' do

    user = create(:regular_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/profile'

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.address)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip)
    expect(page).to have_content(user.email)
    expect(page).to have_link("Edit Profile")
  end
end
