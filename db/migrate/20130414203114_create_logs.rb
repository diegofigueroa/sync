class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :last_state
      t.boolean :updated, :default => false
      t.string :commit
      t.references :project

      t.timestamps
    end
    add_index :logs, :project_id
  end
end
