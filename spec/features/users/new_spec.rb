require 'rails_helper'

RSpec.describe "New registration page", type: :feature do
      context "as a visitor" do
        before(:each) do
          @user_info1 = {name:     "Mike Dao",
                         address:  "100 W 14th Ave Pkwy",
                         city:     "Denver",
                         state:    "CO",
                         zip:      "80204",
                         email:    "quokka@example.com",
                         password: "mikepw"}

          @user_info2 = {name:     "Meg Stang",
                         address:  "1331 17th St",
                         city:     "Denver",
                         state:    "CO",
                         zip:      "80202",
                         email:    "unicorn@example.com",
                         password: "megpw"}
        end

        it "can create a new profile for the registration form" do
          visit "/items"
          click_link "Register"

          expect(current_path).to eq("/register")
          expect(page).to have_content("New Registration Form")

          fill_in :name, with: @user_info1[:name]
          fill_in :address,	with: @user_info1[:address]
          fill_in :city, with: @user_info1[:city]
          fill_in :state,	with: @user_info1[:state]
          fill_in :zip,	with: @user_info1[:zip]
          fill_in :email,	with: @user_info1[:email]
          fill_in :password, with: @user_info1[:password]
          fill_in :password_confirmation,	with: @user_info1[:password]
          click_button "Submit"

          expect(current_path).to eq("/profile")
          expect(page).to have_content("Welcome #{@user_info1[:name]}! You are now registered and logged in!")
        end

        it "cannot create a new profile with an email address already in use" do
          visit "/register"
          fill_in :name, with: @user_info1[:name]
          fill_in :address,	with: @user_info1[:address]
          fill_in :city, with: @user_info1[:city]
          fill_in :state,	with: @user_info1[:state]
          fill_in :zip,	with: @user_info1[:zip]
          fill_in :email,	with: @user_info1[:email]
          fill_in :password, with: @user_info1[:password]
          fill_in :password_confirmation,	with: @user_info1[:password]
          click_button "Submit"

          visit "/register"
          fill_in :name, with: @user_info2[:name]
          fill_in :address,	with: @user_info2[:address]
          fill_in :city, with: @user_info2[:city]
          fill_in :state,	with: @user_info2[:state]
          fill_in :zip,	with: @user_info2[:zip]
          fill_in :email,	with: @user_info1[:email]
          fill_in :password, with: @user_info2[:password]
          fill_in :password_confirmation,	with: @user_info2[:password]
          click_button "Submit"

          expect(current_path).to eq("/register")
          expect(page).to have_content("Email has already been taken")
          expect(page).to have_field(:name, with: @user_info2[:name])
          expect(page).to have_field(:address, with: @user_info2[:address])
          expect(page).to have_field(:city, with: @user_info2[:city])
          expect(page).to have_field(:state, with: @user_info2[:state])
          expect(page).to have_field(:zip, with: @user_info2[:zip])
        end

        it "cannot create a new profile with missing required fields" do
          visit "/register"
          fill_in :name, with: @user_info1[:name]
          fill_in :address,	with: @user_info1[:address]
          fill_in :city, with: @user_info1[:city]
          fill_in :state,	with: @user_info1[:state]
          # Missing zip field
          fill_in :email,	with: @user_info1[:email]
          fill_in :password, with: @user_info1[:password]
          fill_in :password_confirmation,	with: @user_info1[:password]
          click_button "Submit"

          expect(current_path).to eq("/register")
          expect(page).to have_content("Zip can't be blank")
        end

      end
    end