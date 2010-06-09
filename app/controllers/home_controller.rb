class HomeController < ApplicationController
  
  layout 'application'
  
  def index
      
      @runs = Run.all(:conditions => {:showincarrusel => true})
      @campaigns = Campaign.all
      render :layout => 'home'
      
  end

  def about
  end

  def terms
  end

  def services
  end

  def contact
  end

  def inscription_in_newsletter
    # params[:id] is always 0
    
    EmailNotification.deliver_inscription_in_newsletter(params[:email], params[:name])
    flash[:notice] = "Gracias por recibir el boletín de noticias"
    redirect_to("/")
    
  end

end
