require 'rails_helper'

RSpec.describe 'User Show Page' do
  describe 'As an Admin' do
    before :each do
      @merchant = create(:merchant)
      @merchant_employee = create(:merchant_employee, merchant_id: @merchant.id)

      @regular_user1 = create(:regular_user)
      @regular_user2 = create(:regular_user)

      @admin = create(:admin_user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'I see all info a user sees, without edit ability' do
      visit '/admin/users'

      within "#user-#{@regular_user1.id}" do
        click_link @regular_user1.name
      end

      expect(current_path).to eq("/admin/users/#{@regular_user1.id}")
      expect(page).to have_content(@regular_user1.name)
      expect(page).to have_content(@regular_user1.email)
      expect(page).to have_content(@regular_user1.address)
      expect(page).to have_content(@regular_user1.city)
      expect(page).to have_content(@regular_user1.state) 
      expect(page).to have_content(@regular_user1.zip)

    end
  end
end
