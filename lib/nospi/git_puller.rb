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
    
    puts project.source_code_url
    
    tmp_path = project.tmp_path
    repo = Grit::Git.new(tmp_path)
    result = nil
    
    process = repo.clone({:process_info => true, :progress => true, :timeout => false}, url, tmp_path)
    if process
      repo = Grit::Repo.new(tmp_path)
      last_commit = repo.commits.first
      
      updated = ! project.logs.exists?(:last_state => last_commit.id, :synced => true) # project changed
      
      log = project.logs.create action: "pull", last_state: last_commit.id, updated: updated, level: "info"
      result = {source_path: tmp_path, log: log}
    end
    
    result
  end
  
end