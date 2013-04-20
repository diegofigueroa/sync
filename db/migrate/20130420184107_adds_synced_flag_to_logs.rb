class AddsSyncedFlagToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :synced, :boolean, :default => false
  end
end
