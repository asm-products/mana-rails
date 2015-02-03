class Team < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :roles
  has_many :projects
  has_many :clients
  has_many :issues, through: :projects

  validates_presence_of :name

  before_create do
    i = nil
    loop do
      self.slug = name.gsub(/[^0-9a-z]/i, '').downcase + i.to_s
      i ||= 0;
      i += 1
      break if !Team.where(slug: self.slug).exists?
    end
  end

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
