require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'instance methods' do
    before(:each) do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @cart = Cart.new({@chain.id.to_s => 1})
    end

    it 'add_item' do
      @cart.add_item(@chain.id.to_s)
      expect(@cart.contents[@chain.id.to_s]).to eq(2)
    end

    it 'remove_item' do
      @cart.remove_item(@chain.id.to_s)
      expect(@cart.contents[@chain.id.to_s]).to eq(0)
    end

    it 'total_items' do
      @cart.add_item(@chain.id.to_s)
      expect(@cart.total_items).to eq(2)
    end

    it 'items' do
      @cart.add_item(@chain.id.to_s)

      expect(@cart.items).to eq({@chain => 2})
    end

    it 'subtotal' do
      @cart.add_item(@chain.id.to_s)

      expect(@cart.subtotal(@chain)).to eq(100)
    end

    it 'total' do
      @cart.add_item(@chain.id.to_s)

      expect(@cart.total).to eq(100)
    end

    it 'limit_reached?' do
      expect(@cart.limit_reached?(@chain.id.to_s)).to eq(false)

      4.times do
        @cart.add_item(@chain.id.to_s)
      end

      expect(@cart.limit_reached?(@chain.id.to_s)).to eq(true)
    end

    it 'quantity_zero?' do
      expect(@cart.quantity_zero?(@chain.id.to_s)).to eq(false)
      
      @cart.remove_item(@chain.id.to_s)

      expect(@cart.quantity_zero?(@chain.id.to_s)).to eq(true)
    end
  end
end