class Project < ActiveRecord::Base
  
  TYPES = %w(git svn zip tar tgz tbz)
  
  GIT = 0
  SVN = 1
  ZIP = 2
  TAR = 3
  TGZ = 4
  TBZ = 5
  
  attr_accessible :description, :name, :project_url, :source_code_url, :vcs
  
  validates :source_code_url, presence: true
  validates :vcs, presence: true, inclusion: {in: TYPES}
  
  has_many :logs
  
  def friendly_name
    name.downcase.gsub(" ", "-")
  end

end
