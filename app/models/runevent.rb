class Runevent < ActiveRecord::Base
  belongs_to :run
  has_many :payconds
  has_many :inscriptions
  
  def get_amount(user_age, sex)
    
    user_age == 0 ?  tmp_user_age = 30 : tmp_user_age = user_age.to_i
    sex = true if sex.nil?
    
    accepted_payconds = []
    its_payconds = payconds
    its_payconds.each do |pc|
      if tmp_user_age >= pc.from_age && tmp_user_age <= pc.to_age
        sex ? user_sexmode = 2 : user_sexmode = 3
        if pc.sexmode == 1 || user_sexmode == pc.sexmode
          accepted_payconds << (pc.amount + pc.amount_extra) #return pc.amount + pc.amount_extra
        end
      end
    end
    if accepted_payconds.length > 0
      return accepted_payconds.max { |x,y| y <=> x }
    else
      return (self.default_amount + self.default_amount_extra)
    end
  end
  
  def runname_plus_name
    "#{run.name} - #{self.name}"
  end
end
