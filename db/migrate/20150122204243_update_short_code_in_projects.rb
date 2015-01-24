class UpdateShortCodeInProjects < ActiveRecord::Migration
  def change
    remove_index :projects, :short_code
    add_index :projects, :short_code
  end
end
