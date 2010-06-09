class Result < ActiveRecord::Base

  has_many   :responses
  
  belongs_to :user
  belongs_to :run

  CUSTOM_RESULT_LOGO = "/images/default_custom_run_result_icon.jpg"

  def time_chip_civil
    if self.time_chip_in_seconds
      Result::seconds_to_time(self.time_chip_in_seconds)
    else
      time_civil
    end
  end

  def self.calculate_paso(secs, kms)
    if kms && secs
      paso_secs = secs / kms  if kms > 0
      return paso_secs
    else
      return 0
    end
  end

  def time_civil
    Result::seconds_to_time(self.time_in_seconds)
  end
  
  def paso_civil
    Result::seconds_to_time(self.paso_in_seconds)
  end
  
  def full_name(link=true)
    if user
      if link
        "<a href='#{user.profile_path}'>#{user.full_name}</a>"
      else
        user.full_name
      end
    else
      self.custom_full_name
    end
  end
  
  def custom_full_name
    "#{self.firstname} #{self.lastname}"
  end
  
  def self.secs_to_time(secs)
  	Result::seconds_to_time(secs)
  end
  
  
  
  def self.seconds_to_time(secs)
    chip_seconds = secs
    if chip_seconds >= 3600
      hours = chip_seconds / 3600
      chip_seconds -= 3600 * hours
    end
      
    minutes = chip_seconds / 60
    chip_seconds -= 60 * minutes
    seconds = chip_seconds
      
    str = ""
    hours = "%02d" % hours if hours
    minutes = "%02d" % minutes if minutes
    seconds = "%02d" % seconds
    
    str << "#{hours.to_s}:" if hours
    str << "#{minutes.to_s}:" if minutes
    str << "#{seconds.to_s}"
    return str
  end
  
end
