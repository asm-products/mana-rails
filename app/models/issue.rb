class Issue < ActiveRecord::Base
  before_save :default_values
  belongs_to :project
  belongs_to :team

  validates :subject, presence: true, length: { minimum: 3 }
  validates :project_id, presence: true
  
  def default_values
    self.unique_id = unique_id || set_unique_id
    set_project_projected_hours
    self.projected_hours = projected_hours || 0.0
  end
  
  def set_unique_id
    self.project.issues.count + 1
  end
  
  def set_project_projected_hours
    sum_hours = self.project.issues.sum(:projected_hours)
    self.project.update_attribute(:projected_hours, sum_hours)
  end
end
