require 'grit'

class GitPusher

  def self.push project, tmp_path, branch = 'master'
    url = project.repo_name
    name = project.friendly_name
    
    repo = self.find_repo name
    unless repo
      repo = self.create_repo name
    end
    
    system "cd #{tmp_path} && git remote add #{name} #{url}"
    system "cd #{tmp_path} && git push #{name} --mirror"
  end
  
  # TODO: create github repo with provided name
  def self.create_repo name
    credentials = GithubSettings.first        # change this if per user settings enabled
    if credentials
      gh = authorize credentials
      puts gh.inspect
      repo = gh.repos.create :name => name #, :org => credentials.organization
    else
      Rails.logger.error "Couldn't find github credentials."
    end
  end
  
  def self.delete_repo name
    credentials = GithubSettings.first        # change this if per user settings enabled
    if credentials
      gh = authorize credentials
      repo = gh.repos.delete credentials.username, name
    else
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
      end
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
