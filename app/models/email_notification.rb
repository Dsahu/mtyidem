class EmailNotification < ActionMailer::Base

  def signup(user)
    
  end

  def inscription(ins, to, new_pwd="")

    @subject = "Inscripcion confirmada para #{ins.run.name}"
    @recipients = [to]
    #@from = 'no-reply@idemsport.com'
    #@sent_on = Time.now
      @body["title"] = "Inscripcion confirmada para #{ins.run.name}"
      @body["email"] = 'no-reply@idemsport.com'
      @body["message"] = ""
      
      @info = Hash.new
      @info["run"] =  ins.run.name
      @info["event"] = (ins.runevent ? ins.runevent.name : "")
      @info["ficha"] = ins.ficha
      @info["full_name"] = (ins.user ? ins.user.full_name : ins.full_name)
      @info["amount"] = ins.amount
      @info["date"] = ins.run.eventday
      @info["email"] = to
      @info["pwd"] = new_pwd

      @info["age"] = ins.age.to_s
      @info["category"] = (ins.runner_category ? "#{ins.runner_category.name} (#{ins.runner_category.color})" : "")
      @info["sex"] = (ins.sex ? "Hombre" : "Mujer")
      @info["club"] = ins.club
      @info["ciudad"] = ins.city
      @info["tel"] = ins.phone
    @headers = {}

  end

  def invitation(invitation)

    @subject = "#{invitation.user.full_name} te invita a idemsport.com"
    @recipients = [invitation.email]
    @headers = {}

    @body["message"] = ""
    @info = Hash.new
    @info["by_user"] = invitation.user
    @info["name"] = invitation.name
    @info["to_email"] = invitation.email

  end

  def news(msg, to)
    
  end

  def password_change(to, pwd)
    @subject = "Nuevo password - idemsport"
    @recipients = to
    
    @body["title"] = "Nuevo password - idemsport"
    @body["email"] = 'no-reply@idemsport.com'
    @body["message"] = "Los datos de aceso son:<br/>Email: #{to}<br/>Password: #{pwd}"
  end

  def inscription_in_newsletter(from, name)
    
    @subject = "Newsletter - New User"
    @recipients = "info@idemsport.com"
    
    @body["title"] = "Newsletter - New User"
    @body["email"] = 'no-reply@idemsport.com'
    @body["message"] = "#{from} - #{name}"
    
  end

end
