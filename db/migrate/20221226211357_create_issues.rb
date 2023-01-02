class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.text :issue_description
      t.datetime :solved_at
      t.text :feedback
      t.references :user
      t.references :item
      
      t.timestamps
    end
  end
end
