require 'digest/sha1'
class User < ActiveRecord::Base
  
  DEFAULT_PROFILE_PIC_PATH = "/images/blank_profile.jpg"
  
  has_many :uservideoassignments
  has_many :videos, :through => :uservideoassignments
  has_many :videocomments
  has_many :results
  
  has_many :inviters, :foreign_key => "inviter_id", :class_name => "Friendrelation"
  has_many :others,   :foreign_key => "other_id",   :class_name => "Friendrelation"
  
  has_many :friend_requests,      :foreign_key => "other_id",   :class_name => "FriendRequest"
  has_many :sent_friend_requests, :foreign_key => "inviter_id", :class_name => "FriendRequest"

  


  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :email, :firstname, :lastname, :bday
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  #validates_length_of       :login,    :within => 3..40
  validates_length_of       :email, :firstname, :lastname,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  before_save :encrypt_password
  before_create :make_activation_code 
  after_create :wall_event
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :id, :email, :password, :password_confirmation, :firstname, :lastname, :street1, :street2, :zip, :city, :state_id, :country_id, :bday, :profilepic, :default_dress_size, :sex, :club

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def active?
    # the existence of an activation code means they have not activated yet
    
    # IMPORTANT UN-COMMENT LINE!!!!
    #activation_code.nil?
    true
  end

  # Authenticates a user by their email name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password.strip)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def change_password!(pwd)
    return if pwd.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--")
    self.crypted_password = encrypt(pwd.strip)
    self.save
  end

  def full_name
  	return "#{self.firstname} #{self.lastname}"
  end
 
  def open_friend_requests
    FriendRequest.find(:all, :conditions => {:other_id => self.id, :status => FriendRequest::NEW})
  end

  def self.is_mail?(mail)
    r = Regexp.new(/\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/)     
    emails = mail.scan(r).uniq
    if emails.length > 0
      true
    else
      false
    end
  end

  def profilepic
    if super
      super
    else
      DEFAULT_PROFILE_PIC_PATH
    end
  end
 
  def crop_profilepic
    if self.s_profilepic
      self.s_profilepic
    else
      DEFAULT_PROFILE_PIC_PATH
    end
  end
 
  def has_friend_requst(user)

    friendrequests = FriendRequest.find(:all, :conditions => ["status = ?  and ((inviter_id = ? and other_id = ?) OR (other_id = ? and inviter_id = ?))", FriendRequest::NEW, self.id, user.id, self.id, user.id])
    return false unless friendrequests

    if friendrequests.length > 0
      return true
    else
      return false
    end

    #return friendrequests.map { |fr| fr.other_id }.include?(user.id) || friendrequestgotten.map { |fr| fr.inviter_id }.include?(user.id)
  end
  
  def profile_urlnickname
    #return self.urlnickname if self.urlnickname
    return self.id.to_s
  end
  
  def profile_path
    "/profile/p/#{profile_urlnickname}"
  end
  
  def profile_anchor(text_method)
    "<a href='/profile/p/#{self.id}'>#{self.send(text_method)}</a>"
  end
  
  def is_friend_of(user, friendarr=nil)
    #debugger
    
    friendarr = friends unless friendarr
    
    user.is_a?(Fixnum) ? user_id = user : user_id = user.id
    if friendarr.count > 0
      if friendarr.first.is_a? Fixnum
        return friendarr.include?(user_id)
      else
        return friendarr.map {|f| f.id }.include?(user_id)
      end
    end
    return false
  end
  
  def friends(users_loaded=false)
    friend_user_ids = []
    inviters.each { |inv| friend_user_ids << inv.other_id }
    others.each { |inv| friend_user_ids << inv.inviter_id }

    if users_loaded
      # Array of users which are your friends
      in_str = "id IN (" << friend_user_ids.map {|u| u.to_s }.join(",") << ")"
      return User.find(:all, :conditions => [in_str]) unless in_str == "id IN ()"
      return []
    else
      # Array of user IDs which are your friends
      return friend_user_ids
    end
  end
 
  def pictures_as_album
    # all user pics as array of a 'album' array
    # album array: every element represent one Run and the element itself is an array of the run's pics
    # example: [[run1_pic1, run1_pic2], [run2_pic1, run2_pic2]]
    
    tagged = Userpictureassignment.find(:all, :conditions => {:user_id => self.id})
    
    in_str = tagged.map { |tg| tg.picture_id.to_s }.join(",")
    !in_str.empty? ? pictures = Picture.find(:all, :conditions => ["id IN(#{in_str})"], :order => "run_id desc") : pictures = []

    album_arr = []
    current_album_arr_index = 0
    
    if pictures.count > 0
      current_run_id = pictures.first.run_id 
      album_arr[0] = []
    end
    
    pictures.each do |pic|
       
      current_album_arr_index += 1 unless pic.run_id == current_run_id
      album_arr[current_album_arr_index] = [] if album_arr[current_album_arr_index].nil?
      album_arr[current_album_arr_index] << pic
      
    end
    return album_arr
  end
 
  def self.generate_random_password(len)
    newpass = ""
    chars = ("a".."z").to_a + ("0".."9").to_a
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
 
  def age
    if bday
      u_age = Date.today.year - bday.year
      u_age = u_age - 1 if Date.today.month < bday.month || (Date.today.month == bday.month && bday.day >= Date.today.day)
    end
    u_age
  end
 
  def recent_wallevents(with_response=false)
    if with_response
      Wallevent.find(:all, :conditions => {:user_id => self.id}, :include => [{:responses => :by_user}], :order => "created_at desc", :limit => 20)
    else
      Wallevent.find(:all, :conditions => {:user_id => self.id}, :order => "created_at desc", :limit => 20)
    end

  end
 
  def tagged_to_video(video_id) 
    return true if Uservideoassignment.find(:all, :conditions => {:user_id => self.id, :video_id => video_id}).count > 0
    return false
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code

      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
  
    private
    
    def wall_event
      
      self.activated_at = Date.today
      self.save
      
      we_type = Wallevent::GENERAL_NEWUSER
      
      wall_params = {
        :user_id => self.id,
        :name => "Nuevo Socio de Idemsport <a href='#{self.profile_path}'>#{self.full_name}</a>",
        :we_type => we_type
      }
      
      Wallevent.create!(wall_params)
    end
end
