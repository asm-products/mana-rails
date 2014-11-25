class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :short_code
      t.string :website

      t.timestamps
    end
    add_index :clients, :short_code, unique: true
  end
end
