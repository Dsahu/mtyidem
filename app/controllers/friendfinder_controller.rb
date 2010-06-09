class FriendfinderController < ApplicationController

  #require 'contacts'

  before_filter :login_required
  
  def index
    # just render the search form
    render :action => :index
  end
  
  def search
    @users = User.find(:all, :include => [:friend_requests, :sent_friend_requests], :conditions => ["instr(lcase(email), ?) AND instr(lcase(firstname), ?) AND instr(lcase(lastname), ?)", params[:search][:email].downcase, params[:search][:firstname].downcase, params[:search][:lastname].downcase], :limit => 20)
    render :update do |pg|
      pg.replace_html "results", render(:partial => "results", :locals => {:users => @users}) 
    end
  end

  def invite
    
  end

  def invite_confirm
     @emails_count = params[:ec]
  end

  def invite_send

    @contacts = params[:emailcollection].map {|el| el[:idx] ? [el[:name], el[:email]] : nil}.compact

    @contacts.each do |contact|
      inv = Invitation.new(:user_id => current_user.id, :email => contact.last, :name => contact.first)
      inv.save
      EmailNotification.deliver_invitation(inv)
    end

    #render :nothing => true
    redirect_to "/friendfinder/invite_confirm?ec=#{@contacts.length}"
  end

  def inivte_manual

    @contacts = params[:emails].split(',').map {|email| User::is_mail?(email.strip) ? ["", email.strip] : nil }.compact
    InvitationInput.new(:user_id => current_user.id, :input => params[:emails].split(',').map {|email| User::is_mail?(email.strip) ?  email.strip : nil }.compact.join(',')).save!

    @contacts.each do |contact|
      unless Email.exists?(:name => contact.last, :user_id => current_user.id)
        Email.new(:name=> contact.last, :description => contact.first, :user_id => current_user.id, :from_id => Email::MANUAL).save!
      end
    end

    render :action => :invite_summary
  end

  def invite_summary

    # normalize email param
    params[:email].strip!

    # check if it is email format
    if User::is_mail?(params[:email])

      # Figure out which provider it is.
      # first checking by email (for dump users)
      # if no match then take the user defined provider

      if params[:email].downsize.split('@').last.index('hotmail')
        @contacts = Contacts::Hotmail.new(params[:email], params[:password]).contacts
        from_directory = Email::DIRECTORY_HOTMAIL
      elsif params[:email].downsize.split('@').last.index('gmail')
        @contacts = Contacts::Gmail.new(params[:email], params[:password]).contacts
        from_directory = Email::DIRECTORY_GMAIL
      elsif params[:email].downsize.split('@').last.index('yahoo')
        @contacts = Contacts::Yahoo.new(params[:email], params[:password]).contacts
        from_directory = Email::DIRECTORY_YAHOO
      else
        @contacts = Contacts::new(params[:mail_provider].to_sym, params[:email].downsize, params[:password]).contacts
        from_directory = Email::DIRECTORY
      end

      @contacts.each do |contact|
        unless Email.exists?(:name => contact.last, :user_id => current_user.id)
          Email.new(:name=> contact.last, :description => contact.first, :user_id => current_user.id, :from_id => from_directory).save!
        end
      end


    else
      # is not mail !!
      @contacts = []
    end
  end

end
