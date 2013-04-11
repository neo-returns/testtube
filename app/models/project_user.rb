class ProjectUser < ActiveRecord::Base
   include ActionView::Helpers::TextHelper
  belongs_to :project
  belongs_to :user
  belongs_to :invitee
  attr_accessible :project_id, :role, :user_id, :invitee_id

  ROLE_VIEW = "view"
  ROLE_CONTRIBUTE = "contrib"
  ROLE_ADMINISTER = "admin"
  ROLES = {:view => "Viewer", :contrib => "Contributor", :admin => "Administrator"}

  validates_inclusion_of :role, :in => ROLES.map{|role| role[0].to_s }

  def email(current_user)
    retval = !user.nil? ? user.email : invitee.email

    # if the current user is not explicitly assigned to the project,
    # do not show the domain

    # if project.project_users. current_user.present?
    if !project.contribute?(current_user) && !project.admin?(current_user) 
      retval = truncate(retval, :length => 2, :separator => "@", :omission => "[HIDDEN]" )
    end

    return retval
  end
end
