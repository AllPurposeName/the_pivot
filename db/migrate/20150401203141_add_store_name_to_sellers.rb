class AddStoreNameToSellers < ActiveRecord::Migration
  def change
    add_column :sellers, :store_name, :string
  end
end
