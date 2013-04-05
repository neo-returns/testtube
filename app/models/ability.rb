class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user

    puts "********  Evaluating cancan permissions for: " + user.inspect

    # # can :read, Project
    # can :read, Project do |project|
    #   puts "********  Evaluating project permissions for: " + project.inspect
    #   # project.try(project_users).any?{|project_user| project_user.user == user} 
    #   1 == 1
    # end

    
    # alias_action :edit, :destroy, :to => :update


    # you're gonna want to remember this...  read this as:
    # :canCan action to authorize
    #    , obj Type to authorize 
    #    , rails scope to use when there is not a project to check (e.g. index)
    #    , block to use when the project is there (e.g. update)
    can :read, Project, Project.view(user.id) do |project|
      project.view?(user)
    end
    can :update, Project do |project|
      project.admin?(user)
    end
    can :destroy, Project do |project|
      project.admin?(user)
    end
    if !user.id.nil?
      can :create, Project 
    end
    
    # can :read, Project, Project.mine(user.id) do |project|
    #   puts "********  Evaluating read project permissions for: " + project.inspect
    # end

  end
    # add the edit and destroy restful actions to the update cancan action

end

