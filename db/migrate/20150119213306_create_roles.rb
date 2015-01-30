class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :short_code
      t.belongs_to :team
      t.timestamps
    end
  end
end
