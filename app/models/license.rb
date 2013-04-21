class License < ActiveRecord::Base
  attr_accessible :title, :url
  
  def to_s
    title
  end
  
end
