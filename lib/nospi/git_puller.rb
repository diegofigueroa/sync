require 'tempfile'
require 'tmpdir'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'archive/tar/minitar'
require 'rbzip2'
require 'grit'

class GitPuller
  
  def self.pull project
    url = project.source_code_url
    tmp_path = project.tmp_path
    repo = Grit::Git.new(tmp_path)
    result = nil
    
    process = repo.clone({:process_info => true, :progress => true, :timeout => false}, url, tmp_path)
    if process
      # project.status = 1 # not anymore, create a log instead
      
      last_commit = repo.commits.first  # check if this works
      updated = ! project.logs.exists?(:last_state => last_commit) # project changed
      
      log = project.logs.create last_state: last_commit, updated: updated
      result = {source_path: tmp_path, log: log}
    end
    
    result
  end
  
end