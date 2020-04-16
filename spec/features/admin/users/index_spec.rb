require 'rails_helper'

RSpec.describe "Admin Users Index" do
  describe "As an Admin" do

    before :each do
      @merchant = create(:merchant)
      @merchant_employee = create(:merchant_employee, merchant_id: @merchant.id)

      @regular_user1 = create(:regular_user)
      @regular_user2 = create(:regular_user)

      @admin = create(:admin_user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it "I can link to a list of all users" do
      visit '/admin'

      within 'nav' do
        click_link 'Users'
      end

      expect(current_path).to eq('/admin/users')

      within "#user-#{@regular_user1.id}" do
        expect(page).to have_link(@regular_user1.name)
        expect(page).to have_content("Role: #{@regular_user1.role}")
        expect(page).to have_content("Registered: #{@regular_user1.created_at}")
      end

      within "#user-#{@regular_user2.id}" do
        expect(page).to have_link(@regular_user2.name)
        expect(page).to have_content("Role: #{@regular_user2.role}")
        expect(page).to have_content("Registered: #{@regular_user2.created_at}")
      end
    end
  end
end
