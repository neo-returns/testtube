class ProjectUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  attr_accessible :project_id, :role, :user_id

  ROLE_VIEW = "view"
  ROLE_CONTRIBUTE = "contrib"
  ROLE_ADMINISTER = "admin"
  ROLES = {:view => "Viewer", :contrib => "Contributor", :admin => "Administrator"}

  validates_inclusion_of :role, :in => ROLES.map{|role| role[0].to_s }
end