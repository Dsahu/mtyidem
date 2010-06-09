class Userpictureassignment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :tagged_by_user, :foreign_key => "tagged_by_user_id", :class_name => "User"
  belongs_to :picture
  has_one :run, :through => :picture
  after_save :wall_event
  
  private
  
  def wall_event
    
    # FOR THE TAGGED PERSON
    
    tagged_by = "por <a class='wall_event_title_link' href='#{self.tagged_by_user.profile_path}'>si mismo</a>" if self.user_id == self.tagged_by_user_id
    tagged_by = "por <a class='wall_event_title_link' href='#{self.tagged_by_user.profile_path}'>#{self.tagged_by_user.full_name}</a>"
    
    we_type = Wallevent::PICTURE_TAGGED_SELF if self.user_id == self.tagged_by_user_id
    we_type = Wallevent::PICTURE_TAGGED_BY unless self.user_id == self.tagged_by_user_id
    
    wall_params = {
      :picture_id => self.picture_id,
      :user_id => self.user_id,
      :otheruser_id => self.tagged_by_user_id,
      :userpictureassignment_id => self.id,
      
      :run_id => self.picture.run_id,
      
      :we_type => we_type
    }
    
    Wallevent.new(wall_params).do_name.save!
    
    
    # FOR THE TAGGER
    unless self.user_id == self.tagged_by_user_id
      
      tagged_on = "a <a class='wall_event_title_link' href='self.user.profile_path'>#{self.user.full_name}</a>"
      
      we_type = Wallevent::PICTURE_TAGGED_OTHER 
      
      wall_params2 = {
        :picture_id => self.id,
        :user_id => self.tagged_by_user_id,
        :otheruser_id => self.user_id,
        :userpictureassignment_id => self.id,
        #:name => "<a class='wall_event_title_link' href='#{self.tagged_by_user.profile_path}'>#{tagged_by_user.full_name}</a> tageó #{tagged_on} en una <a class='wall_event_title_link' href='/pictures?run=#{picture.run_id}&picture_id=#{picture.id}'>Foto</a>",
        :we_type => we_type
      }
      
      Wallevent.new(wall_params2).do_name.save!
    end
    
  end
  
end
