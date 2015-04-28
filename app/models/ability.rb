class Ability
  include CanCan::Ability

  def get_permissions_for(user)
    permissions = []
    if user.current_membership
      permissions += user.current_membership.roles.map(&:permissions).flatten
      permissions += user.current_membership.permissions
    end
    permissions += Permission.for_everybody
    permissions.uniq
  end

  def guest?(user)
    user.nil? || (user && user.current_team.nil?)
  end

  def setup_guest_abilities(user)
    user = User.new
    can :create, User
    can :create, Team
  end

  def setup_member_abilities(user)
    can :read, Profile do |profile|
      profile.user.memberships.map(&:team).flatten.include? user.current_team
    end
    can :read, User do |check_user|
      check_user.memberships.map(&:team).flatten.include? user.current_team
    end
    get_permissions_for(user).each do |permission|
      can permission.action.to_sym, permission.klass.constantize, permission.condition_hash(user, user.current_team) || permission.condition_block(user, user.current_team)
    end
  end

  def initialize(user)
    if guest?(user)
      setup_guest_abilities(user)
    else
      setup_member_abilities(user)
    end

    # Handle Admins
    can :manage, :all if user.admin?

    # can :manage, Project, team_id: user.team_id
    # can :manage, Issue, team_id: user.team_id
#    can :manage, Client, team_id: user.team_id
    # can :manage, Contact, :client => {team_id: user.team_id}
    # can :manage, User, id: user.id
    # can :read, User, team_id: user.team_id
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
