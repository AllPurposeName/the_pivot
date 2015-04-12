class RenameCatIdsToGarmentIds < ActiveRecord::Migration
  def change
    rename_column :order_garments, :cat_id, :garment_id
    rename_column :garment_breeds, :cat_id, :garment_id
  end
end
