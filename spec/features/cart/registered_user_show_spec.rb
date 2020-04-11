require  'rails_helper'

describe "As a registerd user " do
  it "when I add items to my cart and visit my card" do 
    before(:each) do 
      @user = create(:regular_user)
      
      allow_any_instance_of(ApplicationController).to_recieve(:current_user).and_return(@user)

      @item1 = create(:item)
      @item2 = create(:item)
      @item3 = create(:item)
      
      visit "/items/#{@item1.id}"
      click_on "Add To Cart"
      visit "/items/#{@item2.id}"
      click_on "Add To Cart"
      visit "/items/#{@item3.id}"
      click_on "Add To Cart"

      visit '/cart'
    end 

    
    it "I see a button or link indicating that I can check out" do 
      within "#cart-functions" do 
        expect(page).to  have_link("Checkout")
      end 
    end 
  end
end 
    
# And I click the button or link to check out and fill out order info and click create order
# An order is created in the system, which has a status of "pending"
# That order is associated with my user
# I am taken to my orders page ("/profile/orders")
# I see a flash message telling me my order was created
# I see my new order listed on my profile orders page
# My cart is now empty



     
      







