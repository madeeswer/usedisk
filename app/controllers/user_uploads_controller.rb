class UserUploadsController < ApplicationController

  before_filter :require_user, :only => [:index, :upload,:show]

  # GET /uploads
  # GET /uploads.xml
  def index
    get_current_date

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
  end
  

def upload
     get_current_date
#    @date = Date.new
#    id = params[:id]
#    post = Upload.copy( id, params[:upload])
    arguments = params[:upload]

    
    if arguments.nil?
      flash[:notice] = 'Please enter the file to be uploaded.'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
    elsif arguments[:file].size <= 1000000

#    elsif arguments[:file].size <= 100000000
#    if arguments[:file].size <= 000000

      @upload = Upload.new
      @upload[:ip] = request.remote_ip
      #@upload[:data] = arguments[:file].read
      if !(arguments[:file] == "" )
        
        @upload[:filename] = arguments[:file].original_filename
        @upload[:size] = arguments[:file].size
        @upload[:user_id] = @current_user.id

        
      end

  
      respond_to do |format|
        if @upload.save
        
          id = @upload[:id]
          post = Upload.copy( id, params[:upload], @current_date)
          if [ post ]
            flash[:notice] = 'Successfully Uploaded.'
            format.html { redirect_to :action => "show", :id => id }
            format.xml  { render :xml => @user_upload, :status => :created, :location => @user_upload }
          else
            flash[:notice] = 'File was unable to upload. Upload was unsuccessfully.'
          end        
        else
        
          flash[:notice] = 'Kindly enter the file path correctly.'
        
         format.html { render :action => "index" }
          format.xml  { render :xml => @user_upload.errors, :status => :unprocessable_entity }
        end
      end
    elsif arguments[:file].size >= 1000000 and arguments[:file].size <= 999000000
      if !(@current_user.nil?)

#    elsif arguments[:file].size <= 100000000
#    if arguments[:file].size <= 000000

      @upload = Upload.new
      @upload[:ip] = request.remote_ip
      #@upload[:data] = arguments[:file].read
      if !(arguments[:file] == "" )
        
        @upload[:filename] = arguments[:file].original_filename
        @upload[:size] = arguments[:file].size

        
      end
        @upload[:user_id] = @current_user.id
  
      respond_to do |format|
        if @upload.save
        
          id = @upload[:id]
          post = Upload.copy( id, params[:upload], @current_date)
          if [ post ]
            flash[:notice] = 'Successfully Uploaded.'
            format.html { redirect_to :action => "show", :id => id  }
            format.xml  { render :xml => @upload, :status => :created, :location => @upload }
          else
            flash[:notice] = 'File was unable to upload. Upload was unsuccessfully.'
          end        
        else
        
          flash[:notice] = 'Kindly enter the file path correctly.'
        
         format.html { render :action => "index" }
          format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
        end
      end


        
      else
            render :action => "login_and_upload_error.html"
      
      end
    else
  
      render :action => "size_error.html"
    end    
  #  render :text => "File has been uploaded successfully"
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    get_current_date
    @upload = Upload.find(params[:id])
    @download_url = params[:id].to_s + "_" + @upload[:filename].to_s + "_" + @current_display_date

    # send_file '/tmp/success.txt'
    #send_file '/tmp/success.txt'
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload }
    end
  end



 end
