class RenameCatsTableToGarments < ActiveRecord::Migration
  def change
    rename_table :cats, :garments
    rename_table :order_cats, :order_garments
    rename_table :cat_breeds, :garment_breeds
  end
end
