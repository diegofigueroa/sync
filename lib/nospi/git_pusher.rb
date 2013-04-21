require 'grit'

class GitPusher

  def self.push project, tmp_path, branch = 'master'
    name = project.repo_name.blank? ? project.friendly_name : project.repo_name
    
    repo = self.find_repo name
    unless repo
      repo = self.create_repo name
    end
    
    push_url = repo.html_url.gsub "github.com", "nasasync:#{CGI::escape('n@s@g1t')}@github.com" # chapuz FEO! maybe request a ssh key and use ssh_url
    
    system "cd #{tmp_path} && git init"
    system "cd #{tmp_path} && git add ."
    system "cd #{tmp_path} && git commit -m 'automatic commit on #{Time.now}'"
    system "cd #{tmp_path} && git remote rm #{name}"
    system "cd #{tmp_path} && git remote add #{name} #{push_url}"
    system "cd #{tmp_path} && git push #{name} --mirror"
    
    project.logs.create action: "push", synced: true, level: "info"    # check response from push command and change synced and level
  end
  
  # TODO: create github repo with provided name
  def self.create_repo name
    credentials = GithubSettings.first        # change this if per user settings enabled
    if credentials
      gh = authorize credentials
      repo = gh.repos.create :name => name #, :org => credentials.organization
      
      if repo
        project.logs.create action: "create repo", level: "info"
      else
        project.logs.create action: "create repo failed", level: "error"
      end
      
      repo
    else
      project.logs.create action: "create repo failed, invalid credentials", level: "error"
      Rails.logger.error "Couldn't find github credentials."
    end
  end
  
  def self.delete_repo name
    credentials = GithubSettings.first        # change this if per user settings enabled
    if credentials
      gh = authorize credentials
      repo = gh.repos.delete credentials.username, name
      
      if repo
        project.logs.create action: "delete repo", level: "info"
      else
        project.logs.create action: "delete repo failed", level: "error"
      end
      
      repo
    else
      project.logs.create action: "delete repo failed, invalid credentials", level: "error"
      Rails.logger.error "Couldn't find github credentials."
    end
  end
  
  def self.find_repo name
    credentials = GithubSettings.first        # change this if per user settings enabled
    if credentials
      gh = authorize credentials
      
      begin
        repo = gh.repos.get credentials.username, name
      rescue
        nil
      end
      
      repo
    else
      Rails.logger.error "Couldn't find github credentials."
    end
  end
  
  def self.authorize credentials
    #gh = Github.new :client_id => credentials.client_id, :client_secret => credentials.client_secret
    #gh.authorize_url redirect_uri: 'http://localhost:3000', scope: 'repo'
    gh = Github.new(:basic_auth => 'nasasync:n@s@g1t')
    gh
  end
  
end
