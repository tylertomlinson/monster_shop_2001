require 'rails_helper'

describe "As a visitor", type: :feature do
    it "can see a nav bar with link to the welcome page, all items, merchants, shopping carts, login/registration" do 

        visit "/"

        within 'nav' do
            click_link 'Home Page'
        end

        expect(current_path).to eq('/')
    end
end
