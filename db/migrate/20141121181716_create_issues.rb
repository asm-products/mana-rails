class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :unique_id
      t.string :subject
      t.text :description
      t.decimal :projected_hours
      t.datetime :due_date
      t.references :project, index: true

      t.timestamps
    end
    add_index :issues, :unique_id
  end
end
