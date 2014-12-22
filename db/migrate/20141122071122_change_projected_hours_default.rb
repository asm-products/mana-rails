class ChangeProjectedHoursDefault < ActiveRecord::Migration
  def change
    change_column_default(:issues, :projected_hours, 0.0)
  end
end
