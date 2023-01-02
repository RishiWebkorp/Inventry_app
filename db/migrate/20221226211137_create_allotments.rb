class CreateAllotments < ActiveRecord::Migration[7.0]
  def change
    create_table :allotments do |t|
      t.datetime :dealloted_at
      t.integer :allotment_quantity
      t.references :user
      t.references :item

      t.timestamps
    end
  end
end
