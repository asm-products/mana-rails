class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :klass
      t.string :action
      t.text :description
      t.string :condition
      t.boolean :is_public

      t.timestamps
    end
  end
end
