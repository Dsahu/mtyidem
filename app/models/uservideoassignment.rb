class Uservideoassignment < ActiveRecord::Base
  validates_uniqueness_of :user_id, :scope => [:video_id]
  
  belongs_to :user
  belongs_to :video
  belongs_to :tagged_by_user, :foreign_key => :tagged_by_user_id, :class_name => "User"
  
  after_save :wall_event
  
  private
  
  def wall_event
    
    we_type = Wallevent::VIDEO_TAGGED_SELF if self.user_id == self.tagged_by_user_id
    we_type = Wallevent::VIDEO_TAGGED_SYSTEM if self.tagged_by_user_id == 0
    
    unless we_type == Wallevent::VIDEO_TAGGED_SYSTEM
    
      tagged_by = "por <a class='wall_event_title_link' href='#{self.tagged_by_user.profile_path}'>si mismo</a>" if self.user_id == self.tagged_by_user_id
      for_user = user
      if for_user
      
        wall_params = {
          :video_id => self.video_id,
          :user_id => self.user_id,
          :otheruser_id => self.tagged_by_user_id,
          :uservideoassignment_id => self.id,
          :run_id => self.video.run_id,
          :we_type => we_type
        }
        
        Wallevent.new(wall_params).do_name.save!
      end
    end
  end
  
end
