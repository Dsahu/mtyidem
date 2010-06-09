class Campaign < ActiveRecord::Base
  has_many :camp_units
  has_many :camp_pics
  
  MODES = ["NADA", "LINK", "CONVOC", "PAGE"]
  
  def mode_to_s
    MODES[self.mode]
  end
  
end
