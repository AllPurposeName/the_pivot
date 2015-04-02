class AddSellerIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :seller_id, :integer
  end
end
