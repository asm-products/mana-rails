class Permission < ActiveRecord::Base
  has_and_belongs_to_many :memberships
  belongs_to :role

  scope :for_everybody, -> { where(is_public: true) }

  def condition_hash user, team
    case condition
    when 'belongs_to_user'
      { id: user.id }
    when 'belongs_to_me'
      { user_id: user.id }
    when 'belongs_to_team'
      { team_id: team.id }
    when 'contact_belongs_to_team'
      { client: {team_id: team.id}}
    else
      {}
    end
  end

  def self.seed_data
    [
      {klass: 'Project', action: 'manage', condition: 'belongs_to_team'},
      {klass: 'Project', action: 'read', condition: 'belongs_to_team', is_public: true},
      {klass: 'Issue', action: 'manage', condition: 'belongs_to_team'},
      {klass: 'Issue', action: 'read', condition: 'belongs_to_team', is_public: true},
      {klass: 'Client', action: 'manage', condition: 'belongs_to_team'},
      {klass: 'Client', action: 'read', condition: 'belongs_to_team', is_public: true},
      {klass: 'Contact', action: 'manage', condition: 'belongs_to_team'},
      {klass: 'User', action: 'read', condition: 'belongs_to_team'},
      {klass: 'User', action: 'manage', condition: 'belongs_to_user', is_public: true},
      {klass: 'Team', action: 'create', is_public: true},
      {klass: 'User', action: 'create', is_public: true}
    ]
  end

  def self.seed only=[]
    only = [only] if only.class==String
    seed_data.each do |attributes|
      if only.empty? || only.include?(attributes[:klass])
        Permission.create!(attributes) unless Permission.where(attributes).any?
      end
    end
  end

end
