class CreateJoinTableForMembershipsPermissionsAndRoles < ActiveRecord::Migration
  def change
    create_join_table :memberships, :permissions
    create_join_table :memberships, :roles
  end
end
