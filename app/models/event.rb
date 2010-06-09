class Event < ActiveRecord::Base
	belongs_to :organizator
  belongs_to :run
  
  def short_name(len=15)
    if self.name.length > len
      return "#{self.name[0,len]}..."
    end
    return self.name
  end
end
