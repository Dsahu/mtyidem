class Wallevent < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :other, :foreign_key => :otheruser_id, :class_name => "User"
  belongs_to :otheruser, :foreign_key => :otheruser_id, :class_name => "User"
  belongs_to :video
  belongs_to :run
  belongs_to :picture
  belongs_to :userpictureassignment
  belongs_to :uservideoassignment
  has_many :responses
  has_many :by_users, :through => :responses
  
  # List of all Wallevent types
  GENERAL_NEWUSER = 1
  
  INSCRIPTION_SUCCESS = 10 # show Run pic -> needs: RUN_ID
        
  PICTURE_TAGGED_OTHER = 20 # Show Fotos; looking for other recent ones to combine them -> needs: PICTURE_ID, OTHERUSER_ID
  PICTURE_TAGGED_SELF = 21
  PICTURE_TAGGED_BY = 22
        
  PICTURE_UPLOADED = 30 # Show Fotos; looking for other recent ones to combine them -> needs: PICTURE_ID
  PICTURE_PROFILEPIC_CHANGE = 35 # when user changes its profile pic
        
  FRIEND_ACCEPTED = 40 # Show User Pic (created 2 events, every user one each) -> needs: OTHERUSER_ID
        
  VIDEO_TAGGED_OTHER = 50 # Show Video Icon -> needs: VIDEO_ID, OTHERUSER_ID
  VIDEO_TAGGED_SELF = 51
  VIDEO_TAGGED_BY = 52
  VIDEO_TAGGED_SYSTEM = 53
        
  WALL_COMMENT = 60 # Show User's picture who wrote the comment -> needs: OTHERUSER_ID
  WALL_COMMENT_DONE = 61 # that event talks about that 'user' did a comment on other's wall

  GROUP_ENTERED = 70 # group pic -> needs: GROUP_ID
  GROUP_COMMENT = 71

  #RESULT_AUTO = 80
  #RESULT_CUSTOM = 81

  
  
  def do_name
    
    pic_id = self.picture_id if self.picture_id
    vid_id = self.video_id if self.video_id
    if pic_id
      #unless self.run_id
        pic = picture
        if pic
          self.run_id = pic.run_id
        end
      #end
    end
    
    if vid_id
      #unless self.run_id
        vid = video
        if vid
          self.run_id = vid.run_id
        end
      #end
    end
    
    self.name = case self.we_type
                  when GENERAL_NEWUSER then "Nuevo Miembro <a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a>"
    
                  when INSCRIPTION_SUCCESS then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> se inscribió en la carrera #{self.run_id ? self.run.name : ''}"
    
                  when PICTURE_TAGGED_OTHER then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> etiquetó a <a class='userlink' href='#{self.other.profile_path}'>#{self.other.full_name}</a> en una <a href='/pictures?run=#{self.run_id}&picture_id=#{self.picture_id}'>Foto</a>"
                  when PICTURE_TAGGED_SELF then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> etiquetó a si mismo en una <a href='/pictures?run=#{self.run_id}&picture_id=#{self.picture_id}'>Foto</a>"
                  when PICTURE_TAGGED_BY then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> fue etiquetado por <a class='userlink' href='#{self.other.profile_path}'>#{self.other.full_name}</a> en una <a href='/pictures?run=#{self.run_id}&picture_id=#{self.picture_id}'>Foto</a>"
                  when PICTURE_UPLOADED then ""
                  when PICTURE_PROFILEPIC_CHANGE then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> cambió su foto de perfil"
                  
                  when FRIEND_ACCEPTED then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> y <a class='userlink' href='#{self.other.profile_path}'>#{self.other.full_name}</a> ahora son amigos"
                  
                  when VIDEO_TAGGED_OTHER then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> etiquetó a <a class='userlink' href='#{self.other.profile_path}'>#{self.other.full_name}</a> en un <a href='/videos/#{self.video_id}'>Video</a>"
                  when VIDEO_TAGGED_SELF then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> etiquetó a si mismo en un <a href='/videos/#{self.video_id}'>Video</a>"
                  when VIDEO_TAGGED_BY then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> fue etiquetado por <a class='userlink' href='#{self.other.profile_path}'>#{self.other.full_name}</a> en un <a href='/videos/#{self.video_id}'>Video</a>"
                  when VIDEO_TAGGED_SYSTEM then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> fue etiquetado en un <a href='/videos/#{self.video_id}'>Video</a>"
                  
                  when WALL_COMMENT then ""
                  when WALL_COMMENT_DONE then "<a class='userlink' href='#{self.user.profile_path}'>#{self.user.full_name}</a> comentó en el muro de <a class='userlink' href='#{self.other.profile_path}'>#{self.other.full_name}</a>"
                  when GROUP_ENTERED then ""
                  when GROUP_COMMENT then ""
              end
    return self
  end
  
  
end
