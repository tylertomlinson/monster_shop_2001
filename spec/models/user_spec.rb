require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
  end

  describe "relationships" do
    it {should have_many :orders}
    it {should belong_to(:merchant).optional}
  end

  describe "roles" do
    it "can be created as a regular user" do
      user = User.create(name:     "Mike Dao",
                         address:  "100 W 14th Ave Pkwy",
                         city:     "Denver",
                         state:    "CO",
                         zip:      "80204",
                         email:    "quokka@example.com",
                         password: "mikepw",
                         role:     0)

      expect(user.role).to eq("regular")
      expect(user.regular?).to be_truthy
    end

    it "can be created as a merchant user" do
      user = User.create(name:     "Cory Westerfield",
                         address:  "2300 Steele St",
                         city:     "Denver",
                         state:    "CO",
                         zip:      "80205",
                         email:    "otter@example.com",
                         password: "mikepw",
                         role:     1)

      expect(user.role).to eq("merchant")
      expect(user.merchant?).to be_truthy
    end

    it "can be created as an admin" do
      user = User.create(name:     "Meg Stang",
                         address:  "1331 17th St",
                         city:     "Denver",
                         state:    "CO",
                         zip:      "80202",
                         email:    "unicorn@example.com",
                         password: "megpw",
                         role:     2)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end
  end
end
