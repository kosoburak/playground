class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
      return
    end

    can :read, :home

    alias_action :create, :read, :update, :destroy, :to => :crud
    resources = [User, Karma]

    resources.each do |resource|
      can [:read, :my, :participating], resource
      can :crud, resource do |r|
        user.has_role? :owner, r
      end
    end

    can [:create, :show, :my, :participating, :karma], Project
    can [:crud], Project do |pr|
      user.has_role? :owner, pr
    end

    can :create, Comment
    can [:destroy, :update], Comment, author_id: user.id

    can [:create, :read], Evaluation
    can :crud, Evaluation do |e|
      user.has_role?(:owner, e) || user.has_role?(:owner, e.project)
    end

    can [:index, :show, :read, :add_user], Position
    can [:crud], Position do |p|
      user.has_role?(:owner, p.project)
    end


    can :create, Message
    can [:received, :sent, :crud], Message do |m|
      user.has_role? :owner, m
    end
    #
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
