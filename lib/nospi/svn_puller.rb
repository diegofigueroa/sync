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
    
    system "mkdir -m -np #{tmp_path}"    
    system "cd #{tmp_path} && wget #{url}"  #This will take a while.

    result
  end
  
end