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
    
    result
  end
  
end