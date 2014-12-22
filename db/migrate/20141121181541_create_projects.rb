class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :short_code
      t.text :description
      t.decimal :projected_hours
      t.datetime :due_date
      t.references :client, index: true

      t.timestamps
    end
    add_index :projects, :short_code, unique: true
  end
end
