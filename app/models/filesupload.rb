require 'rubygems'
require 'roo'
require 'zip/zipfilesystem'
require 'zip/zip'
require 'ftools'
require 'image_size'

class Filesupload < ActiveRecord::Base

    REPLACE = 3
    ADD = 2
    ADD_FORCED = 1
  
    def self.gpdata(upload)
      path = self.get_new_file_path("tmp/gp_datasheets", upload)
      self.write_upload_file(path, upload)
      path
    end


    def self.add_gpdata(path, gp_id, adding = false)
      if path

        unless adding == true
          GpData.delete_all(:grandprix_id => gp_id)
        end

        oo = Excelx.new(path)
        oo.default_sheet = oo.sheets.first

        unless adding == true
          startline = 2
        else
          startline = 1
        end


        startline.upto(oo.last_row) do |line|
          gpdataparams = {
            :grandprix_id => gp_id.to_i,
            :name => oo.cell(line, 1),
            :accum => oo.cell(line, 2)
          }



          tmp_cur_col = 3
          while not oo.cell(1, tmp_cur_col).nil?
            tmp_c = oo.cell(line, tmp_cur_col)
            if tmp_c
              tmp_c = tmp_c.to_s if tmp_c
              tmp_c.strip! if tmp_c
            end
            #tmp_c.chomp! if tmp_c
            if tmp_c
              gpdataparams[:"particip#{(tmp_cur_col-2).to_s}"] = (tmp_c.strip.empty? ? false : true)

            else
              gpdataparams[:"particip#{(tmp_cur_col-2).to_s}"] = false
            end
              tmp_cur_col += 1
          end

          gpdat = GpData.new(gpdataparams)
          gpdat.save
        end

      end
    end
  
    def self.campaign(upload)
      path = self.get_new_file_path("public/campmainpics", upload)
      self.write_upload_file(path, upload)
      self.get_html_path(path)
    end
  
    def self.camp_unit_pic(upload, campunitid = 0)
      path = self.get_new_file_path("public/campunitpic/#{campunitid}", upload)
      self.write_upload_file(path, upload)
      self.get_html_path(path)
    end
  
    def self.camp_pic(upload, campid = 0)
      path = self.get_new_file_path("public/camppictures/#{campid}", upload)
      self.write_upload_file(path, upload)
      self.get_html_path(path)
    end
  
    def self.user_profile_pic(upload, user)
      path = self.get_new_file_path("public/profilepics/#{user.id.to_s}", upload)
      self.write_upload_file(path, upload)
      html_path = self.get_html_path(path)
      user.profilepic = html_path
      
      org_file = "public#{html_path}"
      to_file = "public/profilepics/#{user.id.to_s}/#{rand(5000)}_#{rand(5000)}.#{upload['datafile'].original_filename.split('.').last}"
      html_crop_file_path = self.get_html_path(to_file)
      
      user.s_profilepic = html_crop_file_path if Picture::crop_picture(org_file, to_file, 100,100)
      user.save
    end
  
    def self.upload_file_run_mainphoto(upload, run_id)
      run = Run.find(run_id)
      
      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s
      
      Dir.mkdir(directory) unless File.directory? directory
      
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.mainphoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end
  
    def self.upload_file_run_diplomphoto(upload, run_id)
      run = Run.find(run_id)
      
      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s
      
      Dir.mkdir(directory) unless File.directory? directory
      
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.diplomphoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end
  
    def self.upload_file_run_sponsoringphoto(upload, run_id)
      run = Run.find(run_id)
      
      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s
      
      Dir.mkdir(directory) unless File.directory? directory
      
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.sponsoringphoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end
  
    def self.upload_file_run_mapphoto(upload, run_id)
      run = Run.find(run_id)
      
      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s
      
      Dir.mkdir(directory) unless File.directory? directory
      
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.mapphoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end

    def self.upload_file_run_shirtphoto(upload, run_id)
      run = Run.find(run_id)

      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s

      Dir.mkdir(directory) unless File.directory? directory

      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.shirtphoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end

    def self.upload_file_run_medaillephoto(upload, run_id)
      run = Run.find(run_id)

      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s

      Dir.mkdir(directory) unless File.directory? directory

      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.medaillephoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end

    def self.upload_file_run_trofeophoto(upload, run_id)
      run = Run.find(run_id)

      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s

      Dir.mkdir(directory) unless File.directory? directory

      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.trofeophoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end

    def self.upload_file_run_rifaphoto(upload, run_id)
      run = Run.find(run_id)

      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s

      Dir.mkdir(directory) unless File.directory? directory

      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.rifaphoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end

    def self.upload_file_run_altimetrophoto(upload, run_id)
      run = Run.find(run_id)

      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s

      Dir.mkdir(directory) unless File.directory? directory

      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.altimetrophoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end
  
    def self.upload_file_run_logophoto(upload, run_id)
      run = Run.find(run_id)
      
      name = rand(2000).to_s + "_" + upload['datafile'].original_filename.chomp.delete(" ")
      directory = "public/runs/" + run.id.to_s
      
      Dir.mkdir(directory) unless File.directory? directory
      
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
      File.chmod(0755, path)
      run.logophoto = "/runs/" + run.id.to_s + "/" + name
      run.save
    end


	def self.pictures_from_directory(dir, run_id, upload_user_id, mode=ADD_FORCED)

		accepted_file_formats = ["png", "jpg", "jpeg", "gif"]	
		run = Run.find(run_id)	
	
		picture_files = []
		directory = dir
        #self.unzip_file("tmp/#{zipfile}", directory)
        
        uz_files = Dir[directory + "/*"]
        uz_files.each { |f| picture_files.push(File.new(f)) }
      
	#return "---> #{uz_files.inspect}"
        
        # PROCESSING VIDEO-FILE-ARRAY
      directory = "public/pics/" + run.id.to_s
      Dir.mkdir(directory) unless File.directory? directory

      if mode == REPLACE
        # DELETE ALL FILES IN TABLE WITH RUN_ID
        # DELETE ALL FILES IN FOLDER OF RUN_ID
        mode = ADD_FORCED
      end
      
      if mode == ADD_FORCED
        picture_files.each do |pf|
          
          # copy file to final destination
          begin
            filename = rand(2000).to_s + "_" + pf.original_filename # if it's single file-upload then there is the orginal_filename method
            endpath = File.join(directory, filename)
          rescue
            filename = rand(2000).to_s + "_" + pf.path.split("/").last # if it is a normal File instance then there is no original_filename method
            endpath = File.join(directory, pf.path.split("/").last)
          end
          
          # just if the file is a picture-format
          #if accepted_file_formats.index(endpath.split(".").last.downcase)
            File.copy(pf.path, endpath)
            File.chmod(0755, endpath)
          
            
            # make gallary-sized pic
            to_path_gal = endpath #File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
            #resize_stat = Picture::resize_to_max(endpath, to_path_gal, 550, 450)
            
            
            if true
		        # width and height of gal-sized picture
		        tmp_file = File.open(to_path_gal, "rb") {|f| f.read}
		        pic_size = ImageSize.new( tmp_file ).get_size
		        
		        
		        # make middle-sized pic
		        to_path_mid = to_path_gal #File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
		        #Picture::resize_to_max(endpath, to_path_mid, 275, 225)
		        
		        # make croped-sized pic
		        to_path_crop = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
		        Picture::crop_picture(endpath, to_path_crop, 100, 100)

		        # params for video
		        picparam = {
		          :name => filename,
		          :path => endpath,
		          :run_id => run.id,
		          :visible => true,
		          :counter => 0,
		          :upload_by_user_id => upload_user_id,
		          :width => pic_size[0], # gal-sized
		          :height => pic_size[1], # gal-sized
		          :s_path => to_path_crop,
		          :m_path => to_path_mid,
		          :l_path => to_path_gal
		        }
		        
		        # save new video
		        newpic = Picture.new(picparam)
		        newpic.save
            end
          
        end
      end
		

	end



	def self.pictures_as_zip(zipfile, run_id, upload_user_id, mode=ADD_FORCED)
	
        accepted_file_formats = ["png", "jpg", "jpeg", "gif"]	
		run = Run.find(run_id)	
	
		picture_files = []
		directory = "tmp/zippics/" + rand(10000).to_s
        self.unzip_file("tmp/#{zipfile}", directory)
        
        uz_files = Dir[directory + "/*"]
        uz_files.each { |f| picture_files.push(File.new(f)) }
        
        
        # PROCESSING VIDEO-FILE-ARRAY
      directory = "public/pics/" + run.id.to_s
      Dir.mkdir(directory) unless File.directory? directory

      if mode == REPLACE
        # DELETE ALL FILES IN TABLE WITH RUN_ID
        # DELETE ALL FILES IN FOLDER OF RUN_ID
        mode = ADD_FORCED
      end
      
      if mode == ADD_FORCED
        picture_files.each do |pf|
          
          # copy file to final destination
          begin
            filename = rand(2000).to_s + "_" + pf.original_filename # if it's single file-upload then there is the orginal_filename method
            endpath = File.join(directory, filename)
          rescue
            filename = rand(2000).to_s + "_" + pf.path.split("/").last # if it is a normal File instance then there is no original_filename method
            endpath = File.join(directory, pf.path.split("/").last)
          end
          
          # just if the file is a picture-format
          #if accepted_file_formats.index(endpath.split(".").last.downcase)
            File.copy(pf.path, endpath)
            File.chmod(0755, endpath)
          
            
            # make gallary-sized pic
            to_path_gal = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
            resize_stat = Picture::resize_to_max(endpath, to_path_gal, 550, 450)
            
            
            if resize_stat
		        # width and height of gal-sized picture
		        tmp_file = File.open(to_path_gal, "rb") {|f| f.read}
		        pic_size = ImageSize.new( tmp_file ).get_size
		        
		        
		        # make middle-sized pic
		        to_path_mid = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
		        Picture::resize_to_max(endpath, to_path_mid, 275, 225)
		        
		        # make croped-sized pic
		        to_path_crop = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
		        Picture::crop_picture(endpath, to_path_crop, 100, 100)

		        # params for video
		        picparam = {
		          :name => filename,
		          :path => endpath,
		          :run_id => run.id,
		          :visible => true,
		          :counter => 0,
		          :upload_by_user_id => upload_user_id,
		          :width => pic_size[0], # gal-sized
		          :height => pic_size[1], # gal-sized
		          :s_path => to_path_crop,
		          :m_path => to_path_mid,
		          :l_path => to_path_gal
		        }
		        
		        # save new video
		        newpic = Picture.new(picparam)
		        newpic.save
            end
          
        end
      end
        
	end

    def self.pictures(upload, run_id, upload_user_id, mode=ADD_FORCED)
      # INIT
      accepted_file_formats = ["png", "jpg", "jpeg", "gif"]
      run = Run.find(run_id)
      #pictures = Picture.find(:all, :conditions => {:run_id => run.id})
      picture_files = []
      
      # PREPARE FILE-ARRAY WITH THE PICTURES WHICH HAVE TO BE ATTACHED
      if accepted_file_formats.index(upload['datafile'].original_filename.downcase.split(".").last)
        picture_files.push(upload['datafile'])
      elsif File.extname(upload['datafile'].original_filename.downcase) == ".zip"
        directory = "tmp/zippics/" + rand(2000).to_s
        self.unzip_file(upload['datafile'].path, directory)
        
        uz_files = Dir[directory + "/*"]
        uz_files.each { |f| picture_files.push(File.new(f)) }
      end
      
      # PROCESSING VIDEO-FILE-ARRAY
      directory = "public/pics/" + run.id.to_s
      Dir.mkdir(directory) unless File.directory? directory

      if mode == REPLACE
        # DELETE ALL FILES IN TABLE WITH RUN_ID
        # DELETE ALL FILES IN FOLDER OF RUN_ID
        mode = ADD_FORCED
      end
      
      if mode == ADD_FORCED
        picture_files.each do |pf|
          
          # copy file to final destination
          begin
            filename = rand(2000).to_s + "_" + pf.original_filename # if it's single file-upload then there is the orginal_filename method
            endpath = File.join(directory, filename)
          rescue
            filename = rand(2000).to_s + "_" + pf.path.split("/").last # if it is a normal File instance then there is no original_filename method
            endpath = File.join(directory, pf.path.split("/").last)
          end
          
          # just if the file is a picture-format
          #if accepted_file_formats.index(endpath.split(".").last.downcase)
            File.copy(pf.path, endpath)
            File.chmod(0755, endpath)
          
            
            # make gallary-sized pic
            to_path_gal = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
            Picture::resize_to_max(endpath, to_path_gal, 550, 450)
            
            # width and height of gal-sized picture
            tmp_file = File.open(to_path_gal, "rb") {|f| f.read}
            pic_size = ImageSize.new( tmp_file ).get_size
            
            
            # make middle-sized pic
            to_path_mid = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
            Picture::resize_to_max(endpath, to_path_mid, 275, 225)
            
            # make croped-sized pic
            to_path_crop = File.join(directory, "#{rand(5000)}_#{rand(5000)}.#{endpath.split('.').last}")
            Picture::crop_picture(endpath, to_path_crop, 100, 100)

            # params for video
            picparam = {
              :name => filename,
              :path => endpath,
              :run_id => run.id,
              :visible => true,
              :counter => 0,
              :upload_by_user_id => upload_user_id,
              :width => pic_size[0], # gal-sized
              :height => pic_size[1], # gal-sized
              :s_path => to_path_crop,
              :m_path => to_path_mid,
              :l_path => to_path_gal
            }
            
            # save new video
            newpic = Picture.new(picparam)
            newpic.save
          #end
          
        end
      end
      
    end


	def self.videos_as_zip(zip_file, run_id, upload_user_id, mode=ADD_FORCED)
		# INIT
      run = Run.find(run_id)
      #videos = Video.find(:all, :conditions => {:run_id => run.id})
      video_files = []
      
      # PREPARE FILE-ARRAY WITH THE VIDEOS WHICH HAVE TO BE ATTACHED
      #if File.extname(upload['datafile'].original_filename.downcase) == ".flv"
      #  video_files.push(upload['datafile'])
      #elsif File.extname(upload['datafile'].original_filename.downcase) == ".zip"
        directory = "tmp/zipvids/" + rand(2000).to_s
        self.unzip_file("tmp/#{zip_file}", directory)
        
        uz_files = Dir[directory + "/*"]
        uz_files.each { |f| video_files.push(File.new(f)) }
      #end
      
      # PROCESSING VIDEO-FILE-ARRAY
      directory = "public/vids/" + run.id.to_s
      Dir.mkdir(directory) unless File.directory? directory

      if mode == REPLACE
        # DELETE ALL FILES IN TABLE WITH RUN_ID
        # DELETE ALL FILES IN FOLDER OF RUN_ID
        mode = ADD_FORCED
      end
      
      if mode == ADD_FORCED
        video_files.each do |vf|
          
          # copy file to final destination
          begin
            filename = vf.original_filename # if it's single file-upload then there is the orginal_filename method
            endpath = File.join(directory, filename)
          rescue
            filename = vf.path.split("/").last # if it is a normal File instance then there is no original_filename method
            endpath = File.join(directory, vf.path.split("/").last)
          end
          
          # just if the file is a flash-video
          if endpath.split(".").last.downcase == "flv"
            File.copy(vf.path, endpath)
            File.chmod(0755, endpath)
          
            # params for video
            vidparam = {
              :name => filename,
              :path => endpath,
              :is_start => false,
              :run_id => run.id,
              :visible => true,
              :counter => 0,
              :upload_by_user_id => upload_user_id
            }
            
            # save new video
            newvid = Video.new(vidparam)
            newvid.save
            
            minute = filename.split(".").first.to_i # if 0 don't assign
            
            if minute > 0
              tmp_res = Result.find(:all, :select => "user_id", :conditions => ["run_id = ? and time_in_seconds div 60 = ?", run.id.to_s, minute])
              tmp_res.length > 0 ? user_id = tmp_res.first[:user_id] : user_id = nil
              if user_id && user_id > 0
                uservideoassignment = Uservideoassignment.new(:video_id => newvid.id, :user_id => user_id, :tagged_by_user_id => 0)
                uservideoassignment.save
              end
            end
            
          end
          
        end
      end
	end


    def self.videos(upload, run_id, upload_user_id, mode=ADD_FORCED)
      
      # INIT
      run = Run.find(run_id)
      #videos = Video.find(:all, :conditions => {:run_id => run.id})
      video_files = []
      
      # PREPARE FILE-ARRAY WITH THE VIDEOS WHICH HAVE TO BE ATTACHED
      if File.extname(upload['datafile'].original_filename.downcase) == ".flv"
        video_files.push(upload['datafile'])
      elsif File.extname(upload['datafile'].original_filename.downcase) == ".zip"
        directory = "tmp/zipvids/" + rand(2000).to_s
        self.unzip_file(upload['datafile'].path, directory)
        
        uz_files = Dir[directory + "/*"]
        uz_files.each { |f| video_files.push(File.new(f)) }
      end
      
      # PROCESSING VIDEO-FILE-ARRAY
      directory = "public/vids/" + run.id.to_s
      Dir.mkdir(directory) unless File.directory? directory

      if mode == REPLACE
        # DELETE ALL FILES IN TABLE WITH RUN_ID
        # DELETE ALL FILES IN FOLDER OF RUN_ID
        mode = ADD_FORCED
      end
      
      if mode == ADD_FORCED
        video_files.each do |vf|
          
          # copy file to final destination
          begin
            filename = vf.original_filename # if it's single file-upload then there is the orginal_filename method
            endpath = File.join(directory, filename)
          rescue
            filename = vf.path.split("/").last # if it is a normal File instance then there is no original_filename method
            endpath = File.join(directory, vf.path.split("/").last)
          end
          
          # just if the file is a flash-video
          if endpath.split(".").last.downcase == "flv"
            File.copy(vf.path, endpath)
            File.chmod(0755, endpath)
          
            # params for video
            vidparam = {
              :name => filename,
              :path => endpath,
              :is_start => false,
              :run_id => run.id,
              :visible => true,
              :counter => 0,
              :upload_by_user_id => upload_user_id
            }
            
            # save new video
            newvid = Video.new(vidparam)
            newvid.save
            
            minute = filename.split(".").first.to_i # if 0 don't assign
            
            if minute > 0
              tmp_res = Result.find(:all, :select => "user_id", :conditions => ["run_id = ? and time_in_seconds div 60 = ?", run.id.to_s, minute])
              tmp_res.length > 0 ? user_id = tmp_res.first[:user_id] : user_id = nil
              if user_id && user_id > 0
                uservideoassignment = Uservideoassignment.new(:video_id => newvid.id, :user_id => user_id, :tagged_by_user_id => 0)
                uservideoassignment.save
              end
            end
            
          end
          
        end
      end
    end

    def self.excel_inscriptions(upload, run_id)
      name =  "up_ins_#{rand(10000)}.xlsx"
	  directory = "tmp"
	  # create the file path
	  path = File.join(directory, name)
	  # write the file
	  File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
	  
	  oo = Excelx.new(path)
	  oo.default_sheet = oo.sheets.first
	  xls_header = self.get_spread_header(oo)
	  
	  2.upto(oo.last_row) do |line|
	  
	  	tmp_folio = oo.cell(line, xls_header["folio"])
	  	if tmp_folio
	  
		  	tmp_user_id = oo.cell(line, xls_header["socio"])
		  	if tmp_user_id
		  		if tmp_user_id.is_a?(String) && tmp_user_id.empty?
		  			tmp_user_id = 0
		  		end
		  	end
		  	tmp_user_id = tmp_user_id.to_i
		  	tmp_ins_fecha = oo.cell(line, xls_header["fecha"])
		  	tmp_ins_fecha = Date.today unless tmp_ins_fecha
		  	if tmp_ins_fecha.is_a? Date
		  		if tmp_ins_fecha.year == -4712
		  			tmp_ins_fecha = Date.today
		  		end
		  	end
		  
					  
		  
		  	ins = {}
		  	ins[:user_id] = tmp_user_id
		  	ins[:ficha] = tmp_folio
		  	ins[:ins_date] = oo.cell(line, xls_header["fecha"])
		  	ins[:firstname] = oo.cell(line, xls_header["nombre"])
		  	ins[:lastname] = oo.cell(line, xls_header["apellidos"])
		  	ins[:sex] = (oo.cell(line, xls_header["sexo"]) == "F" ? false : true)
		  	ins[:age] = oo.cell(line, xls_header["edad"])
		  	ins[:color] = oo.cell(line, xls_header["color"])
		  	ins[:city] = oo.cell(line, xls_header["ciudad"])
		  	ins[:phone] = oo.cell(line, xls_header["telefono"])
		  	ins[:email] = oo.cell(line, xls_header["correo"])
		  	ins[:club] = oo.cell(line, xls_header["club"])
		  	ins[:ins_date] = tmp_ins_fecha
		  	ins[:completed_at] = tmp_ins_fecha
		  	ins[:paidfrom_id] = 2
		  	ins[:run_id] = run_id
		  	ins[:runevent_id] = 0

		  	
		  	inscription = Inscription.new(ins)
		  	inscription.save
		  	
		end
	  end
    end

    def self.excel_result_forced(file_name, run_id, remove_all_first = true)
      
      run = Run.find(run_id)

      if remove_all_first
        Result.destroy_all(:run_id => run_id)
        uservideoassignments = Uservideoassignment.find_by_sql("select * from uservideoassignments, videos where uservideoassignments.video_id = videos.id and videos.run_id = #{run_id.to_s} and uservideoassignments.tagged_by_user_id = 0")
        uservideoassignments.each {|x| x.destroy }
      end
      
      oo = Excelx.new("tmp/datasheets/#{run.id.to_s}/#{file_name}")
      oo.default_sheet = oo.sheets.first
      xls_header = self.get_spread_header(oo)
      
      2.upto(oo.last_row) do |line|
        res = {}
        res[:num]                  = oo.cell(line, xls_header["bib_num"])
        res[:cat]                  = oo.cell(line, xls_header["race_group"])
        res[:user_id]              = oo.cell(line, xls_header["socio"]).to_i
        res[:firstname]            = oo.cell(line, xls_header["f_name"])
        res[:lastname]             = oo.cell(line, xls_header["l_name"])
        res[:edad]                 = oo.cell(line, xls_header["age"])
        res[:club]                 = oo.cell(line, xls_header["team"])
        res[:time_in_seconds]      = self.date_string_to_seconds(oo.cell(line, xls_header["gun_time"]))
        res[:time_chip_in_seconds] = self.date_string_to_seconds(oo.cell(line, xls_header["chip_time"]))
        res[:rank_general]         = oo.cell(line, xls_header["all_place"]).to_i
        res[:rank_rama]            = oo.cell(line, xls_header["sex_place"]).to_i
        res[:rank_cat]             = oo.cell(line, xls_header["grp_place"]).to_i
        res[:paso_in_seconds]      = self.date_string_to_seconds(oo.cell(line, xls_header["pace"]))
        res[:run_id]                = run_id

        res[:time_chip_in_seconds1] = self.date_string_to_seconds(oo.cell(line, xls_header["time2"])) #unless oo.cell(line, xls_header["time2"]).to_s.strip.empty?
        res[:time_chip_in_seconds2] = res[:time_in_seconds] - res[:time_chip_in_seconds1] if res[:time_chip_in_seconds1]
        res[:paso_in_seconds1] = Result::calculate_paso(res[:time_chip_in_seconds1], run.distance/2) if res[:time_chip_in_seconds1] > 0 && run.distance
        res[:paso_in_seconds2] = Result::calculate_paso(res[:time_chip_in_seconds2], run.distance/2) if res[:time_chip_in_seconds2] > 0 && run.distance

        # part 1
        # part 2
        # ...
        # pause 1
        # pause 2
        # ...
        
        result = Result.new(res)
        result.save
        
        minute = res[:time_in_seconds]/60.to_i
        user_id = res[:user_id]
        
        if user_id && user_id > 0
          video = Video.find(:first, :select => "id", :conditions => ["run_id = ? AND instr(name, ?)", res[:run_id], minute.to_s])
          if video
            uservideoassignment = Uservideoassignment.new(:user_id => user_id, :video_id => video.id, :tagged_by_user_id => 0)
            uservideoassignment.save
          end
        end
          
      end
       
      return nil
      
      
    end
  
    def self.excel_for_results(upload, run_id)
      
      up_file = upload['datafile'].clone
      
      run = Run.find(run_id)
      
      name = rand(2000).to_s + "_" + up_file.original_filename.chomp.delete(" ")
      directory = "tmp/datasheets/" + run.id.to_s
      Dir.mkdir(directory) unless File.directory? directory
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(up_file.read) }
      File.chmod(0755, path)
      
      Result.destroy_all(:run_id => run_id)
      uservideoassignments = Uservideoassignment.find_by_sql("select * from uservideoassignments, videos where uservideoassignments.video_id = videos.id and videos.run_id = #{run_id.to_s} and uservideoassignments.tagged_by_user_id = 0")
      uservideoassignments.each {|x| x.destroy }
      
      oo = Excelx.new(path)
      oo.default_sheet = oo.sheets.first
      xls_header = self.get_spread_header(oo)
      
      2.upto(oo.last_row) do |line|
        res = {}
        res[:num]                  = oo.cell(line, xls_header["bib_num"]).strip
        res[:cat]                  = oo.cell(line, xls_header["race_group"]).strip
        res[:user_id]              = oo.cell(line, xls_header["socio"]).to_i
        res[:firstname]            = oo.cell(line, xls_header["f_name"])
        res[:lastname]             = oo.cell(line, xls_header["l_name"])
        res[:edad]                 = oo.cell(line, xls_header["age"])
        res[:club]                 = oo.cell(line, xls_header["team"])
        res[:time_in_seconds]      = self.date_string_to_seconds(oo.cell(line, xls_header["gun_time"]))
        res[:time_chip_in_seconds] = self.date_string_to_seconds(oo.cell(line, xls_header["chip_time"]))
        res[:rank_general]         = oo.cell(line, xls_header["all_place"]).to_i
        res[:rank_rama]            = oo.cell(line, xls_header["sex_place"]).to_i
        res[:rank_cat]             = oo.cell(line, xls_header["grp_place"]).to_i
        res[:paso_in_seconds]      = self.date_string_to_seconds(oo.cell(line, xls_header["pace"]))
        res[:run_id]                = run_id

        res[:time_chip_in_seconds1] = self.date_string_to_seconds(oo.cell(line, xls_header["time2"])) #unless oo.cell(line, xls_header["time2"]).to_s.strip.empty?
        res[:time_chip_in_seconds2] = res[:time_in_seconds] - res[:time_chip_in_seconds1] if res[:time_chip_in_seconds1]
        res[:paso_in_seconds1] = Result::calculate_paso(res[:time_chip_in_seconds1], run.distance/2) if res[:time_chip_in_seconds1] && run.distance
        res[:paso_in_seconds2] = Result::calculate_paso(res[:time_chip_in_seconds2], run.distance/2) if res[:time_chip_in_seconds2] && run.distance

        # part 1
        # part 2
        # ...
        # pause 1
        # pause 2
        # ...
        
        result = Result.new(res)
        result.save
        
        minute = res[:time_in_seconds]/60.to_i
        user_id = res[:user_id]
        
        if user_id && user_id > 0
          video = Video.find(:first, :select => "id", :conditions => ["run_id = ? AND instr(name, ?)", res[:run_id], minute.to_s])
          if video
            uservideoassignment = Uservideoassignment.new(:user_id => user_id, :video_id => video.id, :tagged_by_user_id => 0)
            uservideoassignment.save
          end
        end
          
      end
       
      return nil
       
    end
  
    private
    
    def self.get_spread_header(spreadsheet)
      header = {}
      1.upto(spreadsheet.last_column) do |col|
        header[spreadsheet.cell(1, col).downcase] = col.to_i if spreadsheet.cell(1, col)
      end
      return header
    end
  
    def self.date_string_to_seconds(str)
      secs = 0
      str = str.to_s.strip if str
      if str && str.length > 0
        str_split = str.split(":")
        if str_split.length == 3
          h_secs = str_split[0].to_i * 3600
          m_secs = str_split[1].to_i * 60
          s_secs = str_split[2].to_i
          secs = h_secs + m_secs + s_secs
        elsif str_split.length == 2
          m_secs = str_split[0].to_i * 60
          s_secs = str_split[1].to_i
          secs = m_secs + s_secs          
        elsif str_split.length == 1
          secs = str_split[0].to_i
        else
          secs = 0
        end
      end
      return secs
    end
    
    def self.unzip_file (file, destination)
      Zip::ZipFile.open(file) { |zip_file|
       zip_file.each { |f|
         f_path=File.join(destination, f.name)
         FileUtils.mkdir_p(File.dirname(f_path))
         zip_file.extract(f, f_path) unless File.exist?(f_path)
       }
      }
    end
  
    def self.get_new_file_path(root_path, upload_file)
      name = rand(2000).to_s + "_" + upload_file['datafile'].original_filename.chomp.delete(" ")
      Dir.mkdir(root_path) unless File.directory? root_path
      path = File.join(root_path, name)
    end

    def self.write_upload_file(path, upload_file)
      File.open(path, "wb") { |f| f.write(upload_file['datafile'].read) }
      File.chmod(0755, path)
    end

    def self.get_html_path(path)
      arr = path.split("/")
      arr[0] = nil
      str = "/" + arr.compact!.join("/")
      return str
    end
end
