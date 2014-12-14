class Team < ActiveRecord::Base
  has_many :users
  has_many :projects
  has_many :clients
  has_many :issues, through: :projects

  validates_presence_of :name

  def has_user?(user)
    users.each { |u| return true if u == user }
  end

  def add_user(user)
    users << user
    self
  end

  def add_user!(user)
    users << user
    save
  end  

  def set_name(new_name)
    name = new_name
  end

  def set_name!(new_name)
    update name: new_name
  end
end
