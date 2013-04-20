class AddUsernameToGithubSettings < ActiveRecord::Migration
  def change
    add_column :github_settings, :username, :string
  end
end
