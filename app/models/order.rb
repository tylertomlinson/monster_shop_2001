class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :user_id, :status

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_quantity
    item_orders.sum(:quantity)
  end
end
