class AddSpecialKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :special_key, :string
    add_index :users, :special_key
  end
end
