class AddsLicenseToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :license_id, :integer
  end
end
