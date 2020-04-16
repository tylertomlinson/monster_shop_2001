class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  enum status: %w(unfulfilled fulfilled)

  belongs_to :item
  belongs_to :order
  def subtotal
    price * quantity
  end

  def fulfill_item_order
    update(status: "fulfilled")
    item.increment(:inventory, by = -quantity).save!
  end
  
end
