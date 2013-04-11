class Project < ActiveRecord::Base
  
  TYPES = %w(git svn zip tar)
  
  attr_accessible :description, :name, :project_url, :source_code_url, :vcs
  
  validates :source_code_url, presence: true
  validates :vcs, presence: true, inclusion: {in: TYPES}
  
end
