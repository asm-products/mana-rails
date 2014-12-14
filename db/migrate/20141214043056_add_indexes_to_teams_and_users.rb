class AddIndexesToTeamsAndUsers < ActiveRecord::Migration
  def change
    add_index :users, :team_id
    add_index :teams, :name
  end
end
