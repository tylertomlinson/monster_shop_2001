class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates_presence_of :password, on: :create
  validates_uniqueness_of :email
  belongs_to :merchant, optional: true

  enum role: %w(regular merchant admin)

  has_many :orders
end
