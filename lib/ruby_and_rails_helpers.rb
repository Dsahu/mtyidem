

  class String
    def nl2br
      gsub("\n\r","<br>").gsub("\r", "").gsub("\n", "<br />")
    end
    
    def nl2br!
      gsub!("\n\r","<br>").gsub("\r", "").gsub("\n", "<br />")
    end
  end

