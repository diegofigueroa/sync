class AddIntervalToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :interval, :integer
  end
end
