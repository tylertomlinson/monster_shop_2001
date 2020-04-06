require 'rails_helper'

RSpec.describe "New registration page", type: :feature do
      context "as a visitor" do
        it "can create a new profile for the registration form" do
          
            visit "/items"

            click_link "Register"

            expect(current_path).to eq("/register")
            expect(page).to have_content("New Registration Form")
            
            fill_in :name,	with: "Mike Dao"
            fill_in :address,	with: "123 Test address"  
            fill_in :city,	with: "Test"  
            fill_in :state,	with: "CO"  
            fill_in :zip,	with: "80234"  
            fill_in :email,	with: "testemail@email.com"  
            fill_in :password,	with: "test123"  
            fill_in :password_confirmation,	with: "test123"  

            click_button "Submit"
            expect(current_path).to eq("/profile")  
            expect(page).to  have_content("Welcome Mike Dao! You are now registered and logged in!")
        end
      end
    end