require 'tempfile'

class Project < ActiveRecord::Base
  
  TYPES = %w(git svn zip tar tgz tbz)
  INTERVALS = [1, 5, 10, 24]
  
  GIT = 0
  SVN = 1
  ZIP = 2
  TAR = 3
  TGZ = 4
  TBZ = 5
  
  attr_accessible :description, :name, :project_url, :source_code_url, :repo_name, :vcs, :interval , :tag_list
  acts_as_taggable
  
  validates :source_code_url, presence: true 
  validates :vcs, presence: true, inclusion: {in: TYPES}
  validates :interval, presence: true, inclusion: {in: INTERVALS}
  
  has_many :logs
  belongs_to :license
  
  def is_git?
    self.vcs.eql? TYPES[GIT]
  end
  
  def is_svn?
    self.vcs.eql? TYPES[SVN]
  end
  
  def is_zip?
    self.vcs.eql? TYPES[ZIP]
  end
  
  def is_tar?
    self.vcs.eql? TYPES[TAR]
  end
  
  def is_tgz?
    self.vcs.eql? TYPES[TGZ]
  end
  
  def is_tbz?
    self.vcs.eql? TYPES[TBZ]
  end
  
  def is_archive?
    is_zip? || is_tar? || is_tgz? || is_tbz?
  end
  
  def friendly_name
    name.downcase.gsub(" ", "-")
  end
  
  def tmp_path
    Rails.root.join('tmp').join(self.friendly_name).to_path + "/"
  end
end
