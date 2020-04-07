class User < ApplicationRecord
    has_secure_password
    validates_presence_of :name, :address, :city, :state, :zip, :password
    validates_uniqueness_of :email
end