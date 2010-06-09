class CampUnit < ActiveRecord::Base
  belongs_to :campaign
  
  IMAGE_WHERES = ["TOP", "BOTTOM"]
  
end
