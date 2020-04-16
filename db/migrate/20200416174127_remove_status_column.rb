class RemoveStatusColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :item_orders, :status
  end
end
