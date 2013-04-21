class Synchronizer
  INTERVALS = Project::INTERVALS
  
  def self.perform interval
    if INTERVALS.include? interval
      projets = Project.where(interval: interval)
      projets.find_each do |project|
        self.sync project
      end
    else
      msg = "Invalid interval value provided."
      puts msg
      Rails.logger.error msg
    end
  end
  
  def self.sync project
    puts ">>>>>>>>>>>>>>>>>>>>> pulling changes (if any)...."
    if project.is_archive?
      pull_result = ArchivePuller.pull project
    elsif project.is_git?
      pull_result = GitPuller.pull project
    elsif project.is_svn?
      pull_result = SvnPuller.pull project
    else
      pull_result = nil
    end
    
    if pull_result && log = pull_result[:log]
      puts ">>>>>>>>>>>>>>>>>>>>> pushing changes (if any)...."
      if log.updated?
        GitPusher.push project, pull_result[:source_path]
      end
    end
  end
  
  def self.perform_one
    self.perform 1
  end
  
  def self.perform_five
    self.perform 5
  end
  
  def self.perform_ten
    self.perform 10
  end
  
  def self.perform_twentyfour
    self.perform 24
  end
end