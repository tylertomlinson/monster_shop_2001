
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit "/"

      within 'nav' do
        click_link 'Home Page'
      end

      expect(current_path).to eq('/')

      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')

      within 'nav' do 
        click_link "Login"
      end
    
      expect(current_path).to eq('/login')
    
      within 'nav' do
        click_link "Register"
      end
    
      expect(current_path).to eq('/register')
    end


    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
    

    it "I see a 404 on /merchant, /admin, and /profile dashboards" do
      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  
  
  #         User Story 3, User Navigation
  
  # As a default user
  # I see the same links as a visitor
  # Plus the following links
  # - a link to my profile page ("/profile")
  # - a link to log out ("/logout")
  
  # Minus the following links
  # - I do not see a link to log in or register
  
  # I also see text that says "Logged in as Mike Dao" (or whatever my name is)
  
  
  describe 'As a Regular User' do
    it "I see a 404 on /merchant and /admin dashboards" do
      user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")
      
      visit '/admin'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    it "I can see the link to my profile page and a link to logout" do
      user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/"

      expect(page).to have_link("Profile")
      expect(page).to have_link("Logout")
      expect(page).to have_no_link("Login") 
      expect(page).to have_no_link("Register")
      expect(page).to have_content("Logged in as #{user.name}")
    end
  end

  describe 'As a Merchant' do
    it "I see a 404 on /admin dashboard" do
      user = create(:merchant_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/admin'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'As an Admin' do
    it "I see a 404 on /merchant dashboard and /cart" do
      user = create(:admin_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/cart'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
