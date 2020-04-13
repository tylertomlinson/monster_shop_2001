require 'rails_helper'

describe "As a merchant employee", type: :feature do
  describe "When I visit  my merchant dashboard" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
    end

    it 'I see a link to view my own items' do
      visit '/merchant'

      click_link 'View Items'

      expect(current_path).to eq('/merchant/items') 
    end
  end
end



# As a merchant employee
# When I visit my merchant dashboard
# I see a link to view my own items
# When I click that link
# My URI route should be "/merchant/items"