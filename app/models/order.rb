class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :user_id, :status

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  # enum status: %w(pending packaged shipped cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_quantity
    item_orders.sum(:quantity)
  end

  def cancel
    item_orders.where(status: "fulfilled").each do |item_order|
      Item.find(item_order.item_id).increment(:inventory, by = item_order.quantity).save!
    end
    item_orders.update(status: "unfulfilled")
    update(status: "cancelled")
  end
end
