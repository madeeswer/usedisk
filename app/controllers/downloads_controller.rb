class DownloadsController < ApplicationController

  # GET /downloads/1
  # GET /downloads/1.xml
  def show
    get_current_date
    current_user
    @image_id = session.id.to_s.slice(1,5)
    @user_session = UserSession.new
    @user = User.new
    
    #@file_path = Download.download_path(29,'test', '2010-03-25')
    #send_data '/home/madhi/data/2010-03-25/29', :filename => '/home/madhi/data/2010-03-25/29'
    #send_file '/home/madhi/data/2010-03-25/29', :filename => "test"


    @id = params[:id]
    flg = 0
#    verification = download[:verification]
    value = @id.split("_")
    id = value[0]
    len = value.length
    date = value[len -3] + "-" + value[len -2] + "-" + value[len -1] 
    file_path = "/home/maspi0/data/#{date}/#{id}"
    if ( (FileTest.exist?(file_path)) and ( /^[0-9]+$/.match(id)) and (/^[0-9]+-[0-9]+-[0-9]+$/.match(date)))
      
      upload = Upload.find(id,:select =>"filename,permission, user_id,access_mails,description")
      
      if upload.permission == 4
        # specific user id      
        if ! @current_user.nil?
          if /#{@current_user.login}/.match(upload.access_mails)
            flg = 0
          else
            flg = 1
          end
        else
          flg =1 
        end

      elsif upload.permission == 3 
        # only me
        if ! @current_user.nil?
          if @current_user.id != upload.user_id
            flg = 1
          end
        else
          flg =1 
        end
      elsif upload.permission == 2 and @current_user.nil?
        # usedisk user id
        flg = 1  
        
      elsif upload.permission == 1
        #any one   
        a=0   
      end      
      if flg == 1
        render :action => "dont_have_privilege.html"
      else      
        @description = upload.description
        @filename = upload.filename
        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @download }
         end
      end
      
    else
      render :action => "file_not_found.html"
    end
    
    


 #   root = '/images/verifications/'
#    @number = rand(50)
    #@number = 1
#    @image = root + @number.to_s + '.png'

#    render :action => 'show.html.erb'
  end
  
  
  def start
    get_current_date
    current_user
    @user_session = UserSession.new
    @user = User.new
    
    #@file_path = Download.download_path(29,'test', '2010-03-25')
    #send_data '/home/madhi/data/2010-03-25/29', :filename => '/home/madhi/data/2010-03-25/29'

    id = params[:id]
    @id = params[:id]
#    number = params[:number]
    download = params[:download]
#    verification = download[:verification]
    value = id.split("_")
    id = value[0]
    len = value.length
    date = value[len -3] + "-" + value[len -2] + "-" + value[len -1] 
    upload = Upload.find(id)
    
    #if number == verification
    
    
    @download = Download.new
    @download[:ip] = request.remote_ip
    #@upload[:data] = arguments[:file].read
    @download[:upload_id] = id
#    @download[:verification] = verification
#    
    @download[:filename] = upload.filename
    @download[:description] = upload.description
    @download[:uploaded_at] = upload.created_at

    if ! @current_user.nil?
      @download[:user_id] = @current_user.id
    end

    if @download.save

      file_path = "/home/maspi0/data/#{date}/#{id}"
#      send_file '/home/madhi/data/2010-03-25/29', :filename => "#{upload.filename}"
      send_file file_path, :filename => "#{upload.filename}",:buffer_size => 2048
    end
    #else
#      redirect_to '/downloads/#{id}'
    #  redirect_to '/downloads/82_a.b.c.txt_2010_04_03'
    #end

#    respond_to do |format|
###      format.html # show.html.erb
#      format.xml  { render :xml => @download }
#    end
  end

end
