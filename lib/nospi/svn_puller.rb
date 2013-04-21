require 'tempfile'
require 'tmpdir'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'archive/tar/minitar'
require 'rbzip2'
require 'grit'

class SvnPuller
  
  def self.pull project
    url = project.source_code_url
    
    system "mkdir #{tmp_path}"    
    system "cd #{tmp_path} && wget -m -np #{url}"  #This will take a while.
    
    log = project.logs.create action: "pull", updated: true, level: "info"
    result = {source_path: tmp_path, log: log}
  end
  
end