require 'tempfile'
require 'tmpdir'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'archive/tar/minitar'
require 'rbzip2'
require 'grit'

class GitPuller

  def self.pull project_id
    project = Project.find project_id
    url = project.source_code_url
    tmpPath = '/tmp/'+project.friendly_name+"/"    
    repo = Grit::Git.new(tmpPath)
  	process = repo.clone({:process_info => true, :progress => true, :timeout => false}, url, tmpPath)
  	if process && project.status == 0
  	  project.status = 1
  	  project.save
  	end
  end

end