require 'tempfile'
require 'tmpdir'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'archive/tar/minitar'
require 'rbzip2'
require 'grit'

class GitPusher

  def self.push project_id, branch = 'master'
    project = Project.find project_id
    url = project.nosi_github_repo_name
    tmpPath = '/tmp/'+project.friendly_name+'/'     #Actualizar Path, al Rails PAth tmp
    
    system('cd '+ tmpPath + ' && ' + 'git remote add ' + project.friendly_name + ' ' + url)
    system('cd '+ tmpPath + ' && ' + 'git push ' + project.friendly_name + ' --mirror')
  end

end
