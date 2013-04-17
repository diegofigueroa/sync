require 'tempfile'
require 'tmpdir'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'archive/tar/minitar'
require 'rbzip2'
require 'grit'

class GitPusher

  def self.addRemote remoteName, repoToPush
  	repo.git.remote({},'add',remoteName,repoToPush)
  end


  def self.push project_id, branch
    project = Project.find project_id
    url = project.source_code_url
    tmpPath = '/tmp/'    

  	repo = Grit::Git.new(tmpPath)
    remote = repo.remotes.last
    self.addRemote project.friendly_name, url
	pusher = repo.git.push({:process_info => true, :progress => true}, project.friendly_name, branch)
  end

end