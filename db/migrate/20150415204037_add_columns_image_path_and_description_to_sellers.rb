class AddColumnsImagePathAndDescriptionToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :image_path, :text
    add_column :sellers, :description, :text
  end
end
