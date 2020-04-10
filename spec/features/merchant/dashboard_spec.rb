require 'rails_helper'

RSpec.describe 'merchant_employee', type: :feature do
  it 'can see what merchant they work for' do

    merchant = create(:merchant)
    employee = create(:merchant_employee, role: 1, merchant_id: merchant.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)

    visit '/merchant'
    save_and_open_page
    within '#merchant-info' do
      expect(page).to have_content(merchant.name)
      expect(page).to have_content(merchant.address)
      expect(page).to have_content(merchant.state)
      expect(page).to have_content(merchant.zip)
    end
  end
end
