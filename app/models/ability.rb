class Ability
  include CanCan::Ability

  def get_permissions_for(user)
    (user.current_membership.roles.map(&:permissions).flatten +
    Permission.for_everybody +
    user.current_membership.permissions).uniq
  end

  def initialize(user)
    if user.nil? || (user && user.current_team.nil?)
      user = User.new
      can :create, User
      can :create, Team
    else
      get_permissions_for(user).each do |permission|
        can permission.action.to_sym, permission.klass.constantize, permission.condition_hash(user, user.current_team)
      end
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
