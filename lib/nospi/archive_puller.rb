require 'tempfile'
require 'tmpdir'
require 'open-uri'
require 'archive/zip'
require 'zlib'
require 'archive/tar/minitar'
require 'rbzip2'

class ArchivePuller
  include Archive::Tar
  
  def self.pull project
    url = project.source_code_url
    file = Tempfile.new([project.friendly_name, ".#{project.vcs}"], Rails.root.join('tmp'), :encoding => 'ascii-8bit')
    result = nil
    
    begin
      file.print open(url).read
      file.flush
      file.close
      
      md5 = Digest::MD5.file(file.path).hexdigest
      
      updated = false
      unless project.logs.exists?(:last_state => md5) # project changed
        updated = true
        
        tmp = Dir.mktmpdir project.friendly_name, Rails.root.join('tmp')
        self.extract file, tmp, project.vcs
      end
      
      log = project.logs.create last_state: md5, updated: updated
      
      result = {source_path: tmp, log: log}
      
    rescue SocketError => e
      Rails.logger.error e.inspect
      file.close
      file.unlink
    end
    
    result
  end
  
  private
  def self.extract file, dest, type
    case type
    when Project::TYPES[Project::ZIP]
      Archive::Zip.extract file.path, dest
    when Project::TYPES[Project::TAR]
      Minitar.unpack file.path, dest
    when Project::TYPES[Project::TGZ]
      tgz =  Zlib::GzipReader.new File.open(file.path, 'rb')
      Minitar.unpack tgz, dest
    when Project::TYPES[Project::TBZ]
      tbz =  RBzip2::Decompressor.new File.open('file', 'rb')
      Minitar.unpack tbz, dest
    end
  end
  
end