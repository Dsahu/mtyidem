require 'spreadsheet'

class AdminController < ApplicationController

  before_filter :admin_required
  layout 'admin'
  
  def index
  
  	@runs = Run.all
  	@new_run = Run.new
  	
  	@links = Link.all
  	@new_link = Link.new
  	
  	@runtypes = Runtype.all
  	@new_runtype = Runtype.new
  	
  	@events = Event.all
  	@new_event = Event.new
  	
  	@organizators = Organizator.all
  	@new_organizator = Organizator.new
    
    @campaigns = Campaign.all
    
    @grandprixes = Grandprix.all
  end

  def gpupload



    path = Filesupload.gpdata(params[:upload])
    ret =  Filesupload.add_gpdata(path, params[:id], params[:adding])

    render :text => "#{ret.inspect}"
    
  end

  def userlist
    if params[:format] == "xls"
      # prepare Spreadsheet
      Spreadsheet.client_encoding = 'UTF-8'
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet :name => 'socios'
      sheet1.row(0).concat %w{Socio Nombre Apellido Email Edad FechaNacimiento Club Sexo Calle Colonia CP Ciudad Cuando }
      
      # prepare Users data
      @users = User.find(:all)
      
      # fill data
      @users.each_with_index do |u, index|
        u_socio = u.id
        u_nombre = u.firstname
        u_apellido = u.lastname
        u_email = u.email
        u_edad = u.age
        u_fechanacimiento = u.bday
        u_club = u.club
        u_sexo = (u.sex ? "Hombre" : "Mujer")
        u_calle = u.street1
        u_colonia = u.street2
        u_zip = u.zip
        u_ciudad = u.city
        u_cuando = u.created_at
        
        sheet1.row(index+1).concat [u_socio, u_nombre, u_apellido, u_email, u_edad, u_fechanacimiento, u_club, u_sexo, u_calle, u_colonia, u_zip, u_ciudad, u_cuando]
      end
      
      # save file
      file_path = "private/report/userlist_#{rand(2000).to_s}.xls"
      book.write file_path
      
      # send_file
      send_file file_path
    else
      render :text => "solo se permite el formato '.xls'"
    end
  end

  def new_inscription_excel
    @runs = Run.all
  end

  def inscription_excel_upload
    @ins_count = Filesupload.excel_inscriptions(params[:upload], params[:run_id])
    
  end

  def inscriptions
    
    if params[:format] == "xls"
    
      # prepare Spreadsheet
      Spreadsheet.client_encoding = 'UTF-8'
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet :name => 'inscriptions'
      sheet1.row(0).concat %w{ID Socio Ficha Nombre Apellido Email Edad Talla Sexo Cuando Pagado Carrera Runevent Club Categoria Color Ciudad Telefono  Origen}
      
      # prepare Inscription data
      @inscriptions = Inscription.find(:all, :include => [:runner_category, :ins_store], :conditions => ["run_id = ? AND completed_at IS NOT NULL", params[:id]])
      
      if @inscriptions.first
      	@rcats = @inscriptions.first.runner_categories
      end
      
      # fill data
      @inscriptions.each_with_index do |ins, index|
        ins_user = ins.user
        ins_id = ins.id
        ins_socio = ins.user_id
        ins_ficha = ins.ficha
        ins_nombre = (ins_user ? ins_user.firstname : ins.firstname)
        ins_apellido = (ins_user ? ins_user.lastname : ins.lastname)
        ins_email = (ins_user ? ins_user.email : ins.email)
        ins_edad = ins.get_age
        ins_talla = ins.dresssize
        ins_sexo = (ins.sex ? "Hombre" : "Mujer")
        ins_cuando = ins.get_completed_at
        ins_pagado = ins.amount
        ins_carrera = "#{ins.run.name} (#{ins.run_id})"
        ins_runevent = "#{ins.get_runevent.name} (#{ins.runevent_id})"
        ins_club = ins.club

        tmp_rc = nil

        tmp_rc = if ins.runner_category_id
        					tmp_rc = ins.runner_category
                            tmp_rc
        				else
        					tmp_name = ""
        					tmp_age = ins.get_age
        					tmp_sex = ins.sex
        					tmp_sex ? tmp_sex = 1 : tmp_sex = 0
        					
        					@rcats.each do |rc|
        						tmp_rc = rc if tmp_age >= rc.from_age && tmp_age <= rc.to_age && tmp_sex == rc.sex_mode
        					end
        					
        					tmp_rc
        				end
        ins_categoria = tmp_rc ? tmp_rc.name : ""
        
        #(ins.runner_category_id ? ins.runner_category.name : "")
        ins_categoria_color = tmp_rc ? tmp_rc.color : ""
        ins_ciudad = ins.city
        ins_telefono = ins.phone
        ins_origen = if ins.paidfrom_id == Inscription::ONLINE
                        "Online"
                     elsif ins.paidfrom_id == Inscription::OFFLINE
                        "Tiendas: #{ins.ins_store}"
                     elsif ins.paidfrom_id == Inscription::BYADMIN
                        "Admin"
                     else
                        ""
                     end
      
        sheet1.row(index+1).concat [ins_id, ins_socio, ins_ficha, ins_nombre, ins_apellido, ins_email, ins_edad, ins_talla, ins_sexo, ins_cuando, ins_pagado, ins_carrera, ins_runevent, ins_club, ins_categoria, ins_categoria_color, ins_ciudad, ins_telefono, ins_origen]
      end
      
      # save file
      file_path = "private/report/inscriptions_#{params[:id]}_#{rand(2000).to_s}.xls"
      book.write file_path
      
      # send_file
      send_file file_path
    else
      render :text => "solo se permite el formato '.xls'"
    end
  end
  
  def up
    @run = Run.find(params[:id]) if params[:id]
    if @run
      @inscription = Inscription.new
      @runevents = @run.runevents
      @ins_stores = @run.ins_stores
  
      @men_count = Inscription.count(:conditions => "sex = 1 and run_id = #{ @run.id} and completed_at IS NOT NULL")
      @women_count = Inscription.count(:conditions => "sex = 0 and run_id = #{ @run.id} and completed_at IS NOT NULL")
    end
  end
  
  def findusers
    @users = User.find(:all, :conditions => ["instr(lcase(email), ?) AND instr(lcase(firstname), ?) AND instr(lcase(lastname), ?)", params[:search][:email].downcase, params[:search][:firstname].downcase, params[:search][:lastname].downcase], :limit => 20)
    render :update do |pg|
      pg.replace_html "findusersresults", render(:partial => "userslist", :locals => {:users => @users})
      pg.show "findusersresults"
    end
  end
  
  def getuser
    @user = User.find(params[:user][:id]) if User.exists?(params[:user][:id])
    if @user
      render :js => "$('#inscription_club').val('#{@user.club}'); $('#inscription_ficha').val(''); $('#inscription_firstname').val('#{@user.firstname}'); $('#inscription_lastname').val('#{@user.lastname}'); $('#inscription_email').val('#{@user.email}'); $('#inscription_age').val('#{@user.age}'); $('#inscription_user_id').val('#{@user.id}'); $('#user_bday_1i').val('#{@user.bday.year}'); $('#user_bday_2i').val('#{@user.bday.month}'); $('#user_bday_3i').val('#{@user.bday.day}');"
                    
    else
      render :js => "alert('El socio ##{params[:user][:id]} no existe. Verificar el numero.')"
    end
  end
  
  def maninsc
    @run = Run.find(params[:id])

    for_user_id = params[:inscription][:user_id]
    already_ins_for_user = Inscription.find(:first, :conditions => ["user_id = ? AND completed_at IS NOT NULL AND run_id != ?", for_user_id.strip, @run.id])

    if already_ins_for_user && params[:inscription][:user_id].to_s.strip.length > 0 && params[:custom][:check].to_s.strip.blank? 


      flash[:error] = "Socio ya tiene inscripcion"



    else


      if params[:custom] && params[:custom][:check] && params[:custom][:check] == "on"
        if params[:custom][:noemail] && params[:custom][:noemail] == "on"

          # Create Inscription without User
          # - Inscription without User
          # - Ficha from Run to Inscription

          @run = Run.find(params[:id])
          @inscription = Inscription.new(params[:inscription])
          @inscription.user_id = nil
          @inscription.completed_at = Time.now
          

          if params[:inscription][:ficha].empty?

            if @run.last_ficha
              @inscription.ficha = (@run.last_ficha + 1)
              @run.last_ficha += 1
              @run.save
            else
              @inscription.ficha = @run.fichastart
              @run.last_ficha = @run.fichastart
              @run.save
            end

          else
            @inscription.ficha = params[:inscription][:ficha].to_i
          end

          @inscription.amount = @inscription.runevent.get_amount(@inscription.get_age, @inscription.sex)
          @inscription.paidfrom_id = (params[:inscription][:ins_store_id].to_s.empty? ? Inscription::BYADMIN : Inscription::OFFLINE)
          @inscription.save

        else
          # Create User and Inscription
          # - User with bday
          # - Random Password
          # - Inscription
          # - Ficha from Run to Inscription

          @user = User.new(:bday => "#{params[:user]["bday(1i)"]}-#{params[:user]["bday(2i)"]}-#{params[:user]["bday(3i)"]}", :firstname => params[:inscription][:firstname], :lastname => params[:inscription][:lastname], :email => params[:inscription][:email], :sex => params[:inscription][:sex].to_i)
          @newpass = User.generate_random_password(6)
          @user.password = @newpass
          @user.password_confirmation = @newpass
          @user.save


          @run = Run.find(params[:id])
          @inscription = Inscription.new(params[:inscription])
          @inscription.user_id = @user.id
          @inscription.completed_at = Time.now

          if params[:inscription][:ficha].empty?

            if @run.last_ficha
              @inscription.ficha = (@run.last_ficha + 1)
              @run.last_ficha += 1
              @run.save
            else
              @inscription.ficha = @run.fichastart
              @run.last_ficha = @run.fichastart
              @run.save
            end

          else
            @inscription.ficha = params[:inscription][:ficha].to_i
          end

          @inscription.amount = @inscription.runevent.get_amount(@inscription.get_age, @inscription.sex)
          @inscription.paidfrom_id = (params[:inscription][:ins_store_id].to_s.empty? ? Inscription::BYADMIN : Inscription::OFFLINE)
          @inscription.save

          EmailNotification.deliver_inscription(@inscription, @user.email, @newpass)

          if @inscription.user_id
            Wallevent.create!(:we_type => Wallevent::INSCRIPTION_SUCCESS,
                              :name=> "#{@inscription.user.profile_anchor(:full_name)} se inscribió en la carrera #{@inscription.run.name} con la ficha ##{@inscription.ficha.to_s}",
                              :description => nil,
                              :user_id => @inscription.user_id)

          end
        end
      else
        if params[:inscription][:user_id] && params[:inscription][:user_id] != "0"
          # Create Inscription
          # - Inscription
          # - Ficha from Run to Inscription

          @user = User.find(params[:inscription][:user_id])
          @inscription = Inscription.new(params[:inscription])
          @run = Run.find(params[:inscription][:run_id])

          @inscription.completed_at = Time.now

          if params[:inscription][:ficha].empty?

            if @run.last_ficha
              @inscription.ficha = (@run.last_ficha + 1)
              @run.last_ficha += 1
              @run.save
            else
              @inscription.ficha = @run.fichastart
              @run.last_ficha = @run.fichastart
              @run.save
            end

          else
            @inscription.ficha = params[:inscription][:ficha].to_i
          end

          @inscription.amount = @inscription.runevent.get_amount(@inscription.get_age, @inscription.sex) - @inscription.run.electronicservicequote
          @inscription.paidfrom_id = (params[:inscription][:ins_store_id].to_s.empty? ? Inscription::BYADMIN : Inscription::OFFLINE)
          @inscription.save

          EmailNotification.deliver_inscription(@inscription, @user.email)

          if @inscription.user_id
            Wallevent.create!(:we_type => Wallevent::INSCRIPTION_SUCCESS,
                              :name=> "#{@inscription.user.profile_anchor(:full_name)} se inscribió en la carrera #{@inscription.run.name} con la ficha ##{@inscription.ficha.to_s}",
                              :description => nil,
                              :user_id => @inscription.user_id)

          end


        else
          # Something went wrong
          # - Give back JS alert
        end
      end


    end


    
  end
  
  def newrun
  	@run = Run.new
  end

  def carreras
  end

  def videos
  end

  def carreratypes
  end

  def videoadminlist
    @run = Run.find(params[:run_id])
    @videos = Video.find(:all, :conditions => {:run_id => params[:run_id]})
    render :layout => false, :action => 'videoadminlist'
  end
  
  def pictureadminlist
    @run = Run.find(params[:run_id])
    @pictures = Picture.find(:all, :conditions => {:run_id => params[:run_id]})
    render :layout => false, :action => 'pictureadminlist'
  end
  
  def upload_file_for_videos
    Filesupload.videos(params[:upload], params[:run_id], current_user.id)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end
  
  def upload_file_for_pictures
    Filesupload.pictures(params[:upload], params[:run_id], current_user.id)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_mainphoto
    Filesupload.upload_file_run_mainphoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_diplomphoto
    Filesupload.upload_file_run_diplomphoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_sponsoringphoto
    Filesupload.upload_file_run_sponsoringphoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_mapphoto
    Filesupload.upload_file_run_mapphoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end
  
  def upload_file_run_logophoto
    Filesupload.upload_file_run_logophoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_shirtphoto
    Filesupload.upload_file_run_shirtphoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_trofeophoto
    Filesupload.upload_file_run_trofeophoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_rifaphoto
    Filesupload.upload_file_run_rifaphoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_altimetrophoto
    Filesupload.upload_file_run_altimetrophoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def upload_file_run_medaillephoto
    Filesupload.upload_file_run_medaillephoto(params[:upload], params[:run_id].to_i)
    render :text => '<a href="javascript:history.back(1)">Regresar</a>'
  end

  def update_wallevents
    # params[:id] describes which ones... the least 10 ones? or when it is 0 or "all" then everyone
    least_ones = params[:id].to_i
    
    if least_ones == 0
      @wallevents = Wallevent.find(:all)
    else
      @wallevents = Wallevent.find(:all, :order => "created_at desc", :limit => least_ones)
    end
    @wallevents.each { |we| we.do_name.save }
  end
  
  def update_profilepics
    @users = User.find(:all, :conditions => ["profilepic IS NOT NULL AND s_profilepic IS NULL"])
    @users.each do |u|
      if u.profilepic
        unless u.s_profilepic
          profilepic_path = "public#{u.profilepic}"
          
          #croped_pic_path = "public/profilepics/#{u.id}/#{rand(5000)}_#{rand(5000)}.#{u.profilepic.split('.').last}"
          html_croped_pic_path = "/profilepics/#{u.id}/#{rand(5000)}_#{rand(5000)}.#{u.profilepic.split('.').last}"
          croped_pic_path = "public#{html_croped_pic_path}"
          
          Picture::crop_picture(profilepic_path, croped_pic_path, 100, 100)
          u.s_profilepic = html_croped_pic_path
          u.save
        end
      end
    end
  end
  
  def update_gallarypics
    @pictures = Picture.find(:all, :conditions => ["l_path IS NULL"])
    @pictures.each do |pic|
      # make gallary-sized pic
      to_path_gal = File.join("public/pics/#{pic.run_id.to_s}", "large_#{rand(5000)}_#{rand(5000)}.#{pic.path.split('.').last}")
      Picture::resize_to_max(pic.path, to_path_gal, 550, 450)
            
      # width and height of gal-sized picture
      tmp_file = File.open(to_path_gal, "rb") {|f| f.read}
      pic_size = ImageSize.new( tmp_file ).get_size
                
      # make middle-sized pic
      to_path_mid = File.join("public/pics/#{pic.run_id.to_s}", "mid_#{rand(5000)}_#{rand(5000)}.#{pic.path.split('.').last}")
      Picture::resize_to_max(pic.path, to_path_mid, 275, 225)
            
      # make croped-sized pic
      to_path_crop = File.join("public/pics/#{pic.run_id.to_s}", "crop_#{rand(5000)}_#{rand(5000)}.#{pic.path.split('.').last}")
      Picture::crop_picture(pic.path, to_path_crop, 100, 100)
      
      pic.width = pic_size[0]
      pic.height = pic_size[1]
      pic.l_path = to_path_gal
      pic.m_path = to_path_mid
      pic.s_path = to_path_crop
      pic.save
    end
  end

end
