class UseBelongsToForUsersAndTeams < ActiveRecord::Migration
  def change
    remove_column :users, :team_id
    add_reference :users, :team 
  end
end
