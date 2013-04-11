class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :project_url
      t.string :source_code_url
      t.string :vcs

      t.timestamps
    end
  end
end
