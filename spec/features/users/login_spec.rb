require 'rails_helper'

RSpec.describe "User can login" do
  context "as a regular user" do
    it "can enter credentials and be redirected to profile page with success message" do
    
        visit "/"

        click_link "Login"

        expect(current_path).to eq "/login" 

        fill_in :email,	with: "ab@c.com"
        fill_in :password,	with: "banana"  

        click_link "Login"

        expect(current_path).to eq("/profile") 
        expect(page).to have_content("Welcome #{regular.name}, you have succesfully logged in!") 


    end

    it "cannot log in with bad credentials" do

        regular = User.create(name: "Joe Bob",
                                address: "777 Street",
                                city: "Detriot",
                                state: "MI",
                                zip: "48127",
                                email: "ab@c.com",
                                password: "banana",
                                role: 0)
        visit "/"

        click_link "Login"

        expect(current_path).to eq "/login" 

        fill_in :email,	with: "ab@c.com"
        fill_in :password,	with: "apple"  

        click_link "Login"

        expect(current_path).to eq("/login") 
        expect(page).to have_content("Please enter valid email and/or password to login")
    end

    it "will be redirected to profile page if already logged in" do
        
        user = create(:regular_user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit "/profile"

        click_link "Login"

        expect(current_path).to eq("/profile") 
        expect(page).to have_content("You are already logged in!") 
    end

    it "can logout and be redirected to welcome page with success message" do
        
    end

    it "will have all items deleted from cart upon logout" do
        
    end
    
    
    
    
  end

  context "as a merchant user" do
    it "can enter credentials and be redirected to merchant dashboard with success message" do
      
    end

    it "will be redirected to merchant dashboard if already logged in" do
        
    end
  end

  context "as an admin user" do
    it "can enter credentials and be redirected to admin dashboard with success message" do
      
    end

    it "will be redirected to admin dashboard if already logged in" do
        
    end
  end

end
