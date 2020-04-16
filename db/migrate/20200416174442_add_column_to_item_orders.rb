class AddColumnToItemOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :item_orders, :status, :integer, default:0
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
