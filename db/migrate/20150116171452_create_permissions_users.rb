class CreatePermissionsUsers < ActiveRecord::Migration
  def change
    create_join_table :users, :permissions
  end
end
