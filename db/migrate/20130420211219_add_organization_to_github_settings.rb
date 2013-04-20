class AddOrganizationToGithubSettings < ActiveRecord::Migration
  def change
    add_column :github_settings, :organization, :string, :default => ""
  end
end
