class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :in_stock
      t.decimal :price
      t.integer :minimum_required_stock
      t.integer :quantity
      t.integer :total_stock
      t.integer :procurement_time_in_weeks
      t.references :brand
      t.references :category
      
      t.timestamps
    end
  end
end
