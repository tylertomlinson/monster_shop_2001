require 'rails_helper'

describe "As a visitor", type: :feature do
    it "can see a nav bar with link to the welcome page, all items, merchants, shopping carts, login/registiration" do 

        visit "/"

        within 'nav' do
            click_link 'Home Page'
        end

        expect(current_path).to eq('/')
        
        within 'nav' do
            click_link 'All Items'
        end

        expect(current_path).to eq('/items')

        within 'nav' do
            click_link 'All Merchants'
        end

        expect(current_path).to eq('/merchants')

        within 'nav' do 
            click_link "Login in"
        end

        expect(current_path).to eq('/login')

        within 'nav' do
            click_link "Register"
        end

        expect(current_path).to eq('/register')

        within 'nav' do
            click_link "Cart"
        end

        expect(current_path).to eq('/cart')
    end
end


# User Story 2, Visitor Navigation

# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/")
# - a link to browse all items for sale ("/items")
# - a link to see all merchants ("/merchants")
# - a link to my shopping cart ("/cart")
# - a link to log in ("/login")
# - a link to the user registration page ("/register")

# Next to the shopping cart link I see a count of the items in my cart