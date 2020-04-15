class AddDefaultImageToItems < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :image, :string, default: "https://images-na.ssl-images-amazon.com/images/I/61DyNlPnnqL._AC_SL1500_.jpg"
  end
end
