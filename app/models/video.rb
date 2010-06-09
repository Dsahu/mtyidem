class Video < ActiveRecord::Base
  
  has_many :uservideoassignments
  belongs_to :run
  has_many :users, :through => :uservideoassignments
  
  def short
    self.name.split(".").first
  end
  
  def html_path
    splitted = self.path.split("/")
    splitted.delete_at(0)
    "/" + splitted.join("/")
  end
  
  def self.get_minute_video(minute, videos)
    videos.each { |vid| return vid.id if vid.name.split(".").first.to_i == minute }
    return nil
  end

  def name_as_time
    a = name.split(".").first
    if a.to_i > 0
      b = a.to_i
      c = ""
      if b > 59
        c << "#{(b/60)}:"
        b -= (b/60) * 60
      end
      c << "%02d" % b
    else
      a
    end
  end

end
