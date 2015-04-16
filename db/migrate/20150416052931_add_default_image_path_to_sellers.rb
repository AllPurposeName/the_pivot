class AddDefaultImagePathToSellers < ActiveRecord::Migration
  def change
    change_column_default :sellers, :image_path, "seller_default.jpg"
  end
end
