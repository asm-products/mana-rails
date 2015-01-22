class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :permissions
end
