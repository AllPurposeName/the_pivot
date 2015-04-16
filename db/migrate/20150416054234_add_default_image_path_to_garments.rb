class AddDefaultImagePathToGarments < ActiveRecord::Migration
  def change
    change_column_default :garments, :image_path, "garment_default.jpg"
  end
end
