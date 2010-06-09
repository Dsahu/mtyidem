class Friendrelation < ActiveRecord::Base
  
  after_save :wallevent
  
  
  private
  
  def wallevent
    Wallevent.new(:we_type => Wallevent::FRIEND_ACCEPTED, 
                  :description => nil, 
                  :user_id => self.inviter_id,
                  :otheruser_id => self.other_id).do_name.save!
                  
    Wallevent.new(:we_type => Wallevent::FRIEND_ACCEPTED, 
                  :description => nil, 
                  :user_id => self.other_id,
                  :otheruser_id => self.inviter_id).do_name.save!
  end
  
end
