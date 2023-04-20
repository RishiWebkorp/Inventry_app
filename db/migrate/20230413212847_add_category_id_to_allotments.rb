class AddCategoryIdToAllotments < ActiveRecord::Migration[7.0]
  def change
    add_column :allotments, :category_id, :integer
  end
end
