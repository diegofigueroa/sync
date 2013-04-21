class AddCenterToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :center, :string
  end
end
