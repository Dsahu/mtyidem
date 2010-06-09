class GpData < ActiveRecord::Base
  belongs_to :grandprix
  
  def name_short(len=30)
    if self.name.length > len
      self.name[0,len] + "..."
    else
      self.name
    end
  end
  
end
