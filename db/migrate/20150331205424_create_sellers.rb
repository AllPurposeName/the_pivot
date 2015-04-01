class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :slug

      t.timestamps null: false
    end
  end
end
