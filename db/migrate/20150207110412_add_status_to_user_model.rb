class AddStatusToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :status, :string
    add_column :users, :available, :boolean
  end
end
