class Log < ActiveRecord::Base
  belongs_to :project
  attr_accessible :commit, :last_state, :updated, :synced, :action, :level
end
