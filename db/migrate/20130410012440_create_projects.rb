class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :project_url
      t.string :source_code_url
      t.string :vcs
      t.string   "nosi_github_repo_name"
      t.integer  "status", :default => 0
      t.timestamps
    end
  end
end
