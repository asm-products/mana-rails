class AddRoleIdToPermissions < ActiveRecord::Migration
  def change
    add_reference :permissions, :role
  end
end
