require 'rails_helper'

RSpec.describe "User can login" do
    context "as a regular user" do
        it "can enter credentials and be redirected to profile page with success message" do

            user = create(:regular_user)

            visit "/"

            click_link "Login"

            expect(current_path).to eq("/login")

            fill_in :email,	with: "#{user.email}"
            fill_in :password,	with: "#{user.password}"

            click_button "Sign In"

            expect(current_path).to eq(profile_path)
            expect(page).to have_content("Welcome #{user.name}, you have successfully logged in!")
        end

        it "cannot log in with bad credentials" do

            user = create(:regular_user)

            visit "/"

            click_link "Login"

            expect(current_path).to eq "/login"

            fill_in :email,	with: "#{user.email}"
            fill_in :password,	with: ""

            click_button "Sign In"

            expect(current_path).to eq("/login")
            expect(page).to have_content("Please enter valid email and/or password to login")
        end

        it "will be redirected to profile page if already logged in" do

            user = create(:regular_user)

            visit '/'

            click_link "Login"

            fill_in :email,	with: "#{user.email}"
            fill_in :password,	with: "#{user.password}"

            click_button "Sign In"

            visit "/login"

            expect(page).to have_content("You are already logged in!")
            expect(current_path).to eq("/profile")
        end

        it "can logout and be redirected to welcome page with success message" do
            user = create(:regular_user)
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

            visit '/'

            click_link "Logout"

            expect(current_path).to eq("/")
            expect(page).to have_content("You have successfully logged out!")
            expect(page).to have_content("Cart: 0")

        end
    end

    context "as a merchant user" do
        it "can enter credentials and be redirected to merchant dashboard with success message" do

            merchant = create(:merchant_employee)

            visit "/"

            click_link "Login"

            expect(current_path).to eq("/login")

            fill_in :email,	with: "#{merchant.email}"
            fill_in :password,	with: "#{merchant.password}"

            click_button "Sign In"

            expect(current_path).to eq(merchant_path)
            expect(page).to have_content("Welcome #{merchant.name}, you have successfully logged in!")
        end

        it "will be redirected to merchant dashboard if already logged in" do

            merchant = create(:merchant_employee)

            visit '/'

            click_link "Login"

            fill_in :email,	with: "#{merchant.email}"
            fill_in :password,	with: "#{merchant.password}"

            click_button "Sign In"

            visit "/login"

            expect(page).to have_content("You are already logged in!")
            expect(current_path).to eq(merchant_path)
        end
    end

    context "as an admin user" do
        it "can enter credentials and be redirected to admin dashboard with success message" do

            admin = create(:admin_user)

            visit "/"

            click_link "Login"

            expect(current_path).to eq("/login")

            fill_in :email,	with: "#{admin.email}"
            fill_in :password,	with: "#{admin.password}"

            click_button "Sign In"

            expect(current_path).to eq(admin_path)
            expect(page).to have_content("Welcome #{admin.name}, you have successfully logged in!")
        end

        it "will be redirected to admin dashboard if already logged in" do

            admin = create(:admin_user)

            visit '/'

            click_link "Login"

            fill_in :email,	with: "#{admin.email}"
            fill_in :password,	with: "#{admin.password}"

            click_button "Sign In"

            visit "/login"

            expect(page).to have_content("You are already logged in!")
            expect(current_path).to eq(admin_path)
        end
    end
end
