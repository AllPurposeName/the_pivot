class RenamingBreedsToCategories < ActiveRecord::Migration
  def change
    rename_table :breeds, :categories
    rename_column :garment_breeds, :breed_id, :category_id
    rename_table :garment_breeds, :garment_categories
  end
end
