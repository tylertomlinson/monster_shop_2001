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
            click_link "Login"
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