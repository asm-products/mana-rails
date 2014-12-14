class AddAssociationsToOtherModelsForTeams < ActiveRecord::Migration
  def change
    add_reference :projects, :team
    add_reference :clients, :team
  end
end
