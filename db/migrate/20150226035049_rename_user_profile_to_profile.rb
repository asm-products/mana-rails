class RenameUserProfileToProfile < ActiveRecord::Migration
  def change
    rename_table :user_profiles, :profiles
  end
end
