class Issue < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :subject
end
