class Picture < ActiveRecord::Base
  
  belongs_to :run
  has_many :userpictureassignments
  has_many :users, :through => :userpictureassignments
    
  def html_path(a_path = nil)
    
    unless a_path
      a_path = self.path
    end
    
    splitted = a_path.split("/")
    splitted.delete_at(0)
    "/" + splitted.join("/")
    
  end
  
  def self.html_path(a_path)
    splitted = a_path.split("/")
    splitted.delete_at(0)
    "/" + splitted.join("/")
  end
  
  def html_l_path
    self.html_path(self.l_path)
  end
  
  def html_m_path
    self.html_path(self.m_path)
  end
  
  def html_s_path
    self.html_path(self.s_path)
  end
  
  def self.max_size(max_width, max_height, for_width=100, for_height=100)
    
    ratio_max = max_width.to_f / max_height.to_f
    ratio_pic = for_width.to_f / for_height.to_f
    
    if ratio_max < ratio_pic
      width_ratio = for_width.to_f / max_width.to_f
      new_height = for_height.to_f / width_ratio
      [max_width.to_i, new_height.to_i]
    else
      height_ratio = for_height.to_f / max_height.to_f
      new_width= for_width.to_f / height_ratio
      [new_width.to_i, max_height.to_i]
    end
  end
  
  def max_size(max_width, max_heigth)
    return Picture::max_size(max_width, max_heigth, self.width, self.height)
  end
  
  
  def self.crop_picture(from_path, to_path, wid, heig)
    
    #begin
      image = MiniMagick::Image.from_file(from_path)
      image.crop_resized(wid, heig)
      image.write(to_path)
      File.chmod(0755, to_path)
      return to_path
    #rescue
      return nil
    #end
    
  end
  
  def self.resize(path, to_path, parameter)
    begin
      image = MiniMagick::Image.from_file(path)
      image.resize(parameter.to_s)
      image.write(to_path)
      File.chmod(0755, to_path)
      return to_path
    rescue
      return nil
    end
  end
  
  def self.resize_to_max(path, to_path, max_width, max_height)
    
    begin
    
      image = MiniMagick::Image.from_file(path)
      
      if image[:width].to_i.to_f / max_width.to_f > 1 &&  image[:width].to_i.to_f / max_width.to_f > image[:height].to_i.to_f / max_height.to_f
        scale = (((max_width.to_f / image[:width].to_i.to_f) * 100) + 3).to_i
        image.resize "#{scale}%"    
      elsif image[:height].to_i.to_f / max_height.to_f > 1 && image[:height].to_i.to_f / max_height.to_f > image[:width].to_i.to_f / max_width.to_f
        scale = (((max_height.to_f / image[:height].to_i.to_f) * 100) + 3).to_i
        image.resize "#{scale}%"
      else
      
      end
      image.write(to_path)
      File.chmod(0755, to_path)
      return true
    rescue
      return false
    end
    
  end
  
end
