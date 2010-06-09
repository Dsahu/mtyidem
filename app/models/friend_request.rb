class FriendRequest < ActiveRecord::Base
  
  belongs_to :inviter, :class_name => "User"
  belongs_to :other,   :class_name => "User"
  
  NEW = 1
  ACCEPTED = 2
  IGNORED = 3
  BLOCKED = 4
  
  validates_presence_of :other_id
  
  def accept
    if Friendrelation.create!(:inviter_id => self.inviter_id, :other_id => self.other_id)
      self.status = ACCEPTED
      save
    else
      false
    end
  end
  
  def ignore
    self.status = IGNORED
    save
  end
  
  def block
    self.status = BLOCKED
    save
  end
end
