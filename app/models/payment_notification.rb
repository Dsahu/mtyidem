class PaymentNotification < ActiveRecord::Base
  belongs_to :inscription
  serialize :params
  after_create :mark_inscription_as_purchased
  
  private
  
  def mark_inscription_as_purchased
    
    self.update_attribute(:purchased_at, Time.now)
    
    if status == "Completed"
      
      ins = Inscription.find(self.inscription_id)
      ins.completed_at = Time.now
      
      run = ins.run
      if run.last_ficha
        ins.ficha = (run.last_ficha + 1)
        run.last_ficha += 1
        run.save

        run.after_inscription_check

      else
        ins.ficha = run.fichastart
        run.last_ficha = run.fichastart
        run.save
      end
      
      user = nil
      
      if ins.user_id > 0
        if User.exists?(ins.user_id)
          user = ins.user
        end
      end
      
      if user
        ins.firstname = user.firstname
        ins.lastname = user.lastname
        usr_email = user.email
        ins.email = usr_email
        ins.sex = user.sex
      end
      
      ins.amount = ins.runevent.get_amount(ins.get_age, ins.sex)
      ins.paidfrom_id = Inscription::ONLINE
      ins.save
      
      user ? (User::is_mail?(user.email.strip) ? mail_to = user.email.strip : mail_to = nil) : (User::is_mail?(ins.email.strip) ? mail_to = ins.email.strip : mail_to = nil) 
      
      if mail_to
        EmailNotification.deliver_inscription(ins, mail_to) if mail_to
      end
      
      if user
        Wallevent.new(:we_type => Wallevent::INSCRIPTION_SUCCESS, 
                      #:name=> "#{ins.user.profile_anchor(:full_name)} se inscribió en la carrera #{ins.run.name} con la ficha ##{ins.ficha.to_s}", 
                      :description => nil, 
                      :user_id => ins.user_id,
                      :run_id => ins.run_id).do_name.save!
        
                          
      end
    end
  end
end
