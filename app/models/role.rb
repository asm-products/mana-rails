class Role < ActiveRecord::Base
  has_and_belongs_to_many :memberships
  has_many :permissions
  belongs_to :team
end
