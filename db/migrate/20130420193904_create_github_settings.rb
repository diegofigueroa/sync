class CreateGithubSettings < ActiveRecord::Migration
  def change
    create_table :github_settings do |t|
      t.string :client_id
      t.string :client_secret

      t.timestamps
    end
  end
end
