class AddDefaultValueToOrderCats < ActiveRecord::Migration
  def up
    change_column :order_cats, :quantity, :integer, default: 1
  end

  def down
    change_column :order_cats, :quantity, :integer, default: nil
  end
end
