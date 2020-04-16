class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :users
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
  validates :active?, inclusion: [true, false]

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def toggle_all_items_status
    items.each do |item|
      item.toggle(:active?)
      item.save
    end

    def pending_orders
      orders.where(status: "pending")
    end
  end
end
