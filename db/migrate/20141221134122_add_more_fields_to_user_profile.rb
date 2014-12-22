class AddMoreFieldsToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :address, :string
    add_column :user_profiles, :secondary_phone, :string
    add_column :user_profiles, :time_zone, :string
    add_column :user_profiles, :twitter_name, :string
  end
end
