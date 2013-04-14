require 'tempfile'
require 'open-uri'

class ZipPuller
  
  def self.pull project_id
    project = Project.find project_id
    url = project.source_code_url
    
    file = Tempfile.new([project.friendly_name, ".#{project.vcs}"], Rails.root.join('tmp'), :encoding => 'ascii-8bit')
    
    begin
      file.print open(url).read
      file.flush
      
      md5 = Digest::MD5.file(file.path).hexdigest
      
      updated = false
      unless project.logs.exists?(:last_state => md5) # project changed
	updated = true
      end
      
      log = project.logs.create last_state: md5, updated: updated
      
    rescue SocketError => e
      Rails.logger.error e.inspect
      file.close
      file.unlink
    end
  end
end