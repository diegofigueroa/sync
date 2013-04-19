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
    tmpPath = '/tmp/'+remoteName+"/"     #Actualizar Path, al Rails PAth tmp
    repo = Grit::Git.new(tmpPath)
    #repo.git.remote({},'rename','origin','upstream')    # This rename will let us upload the code.
  	repo.remote({},'add',remoteName,repoToPush)
  end


  def self.push project_id, branch = 'master'
    require 'grit'
    project = Project.find project_id
    url = project.nosi_github_repo_name
    tmpPath = '/tmp/'+project.friendly_name+"/"     #Actualizar Path, al Rails PAth tmp

  	repo = Grit::Git.new(tmpPath)
    remote = repo.remotes.last
    #
    #self.addRemote project.friendly_name, url
    #sets the remote repo into the project called 'MyRemoteRepo'
    repo.git.remote({},'add',project.friendly_name,url)
    #
    pusher = repo.git.push({:process_info => true, :progress => true}, project.friendly_name, branch)
  end

end
