class UploadsController < ApplicationController
require 'net/smtp'

#  before_filter :require_no_user, :only => [:index, :upload,:show]
  before_filter :require_user, :only => [:destroy]

  # GET /uploads
  # GET /uploads.xml
  def index
	logger.info "ok #{ENV['RUBY_HEAP_MIN_SLOTS']} \n"
	logger.info "#{ENV['PATH']}"
  
    get_current_date
    current_user
    @user_session = UserSession.new
    @user = User.new
    @image_id = session.id.to_s.slice(1,5)
    
    if ! @current_user.nil?
      @uploads = Upload.find(:all, :select => "id, filename, description,created_at", :conditions => "user_id = '#{@current_user.id}'")
      @downloads = Download.find(:all, :select => "id, filename, description, uploaded_at,created_at,upload_id", :conditions => "user_id = '#{@current_user.id}'")
    end



    respond_to do |format|
      format.html # index.html.erb
    end
  end
  

  def upload
    @user_session = UserSession.new
    @user = User.new
    get_current_date
    current_user

    if ! @current_user.nil?
      @uploads = Upload.find(:all, :select => "id, filename, description,created_at", :conditions => "user_id = '#{@current_user.id}'")
      @downloads = Download.find(:all, :select => "id, filename, description, uploaded_at,created_at,upload_id", :conditions => "user_id = '#{@current_user.id}'")
    end

#    @date = Date.new
#    id = params[:id]
#    post = Upload.copy( id, params[:upload])
    arguments = params[:upload]
    to_email = arguments[:to_email]
    from_email = arguments[:from_email]
    storage_type = arguments[:storage_type]
    description  = arguments[:description]
     
      used_space = @current_user.used_space.to_i + arguments[:filename].size.to_i if storage_type.to_i == 2

    if used_space.to_i <= 500000000
      
      if (arguments[:filename].size <= 100000000) and ( @current_user.nil?)
  #    elsif arguments[:file].size <= 100000000
  #    if arguments[:file].size <= 000000
  
        @upload = Upload.new
        @upload[:ip] = request.remote_ip
        @upload[:permission] = arguments[:permission]
        #@upload[:data] = arguments[:file].read
        if !(arguments[:filename] == "" )
          filename = arguments[:filename].original_filename
          @upload[:filename] = filename
          @upload[:size] = arguments[:filename].size
          @upload[:description] = description
        end
  
        if !(arguments[:to_email] == "" )
          @upload[:to_email] = to_email
          if  @current_user
            @upload[:from_email] = @current_user.login
          else
            @upload[:from_email] = from_email
            
          end
        end
      
        if ! @current_user.nil?
          @upload[:user_id] = @current_user.id
          @upload[:storage_type] = arguments[:storage_type]
          @upload[:access_mails] = arguments [:access_mails]
          if storage_type.to_i == 2
            parameters = Hash.new
            parameters[:used_space] = used_space
            @user = @current_user # makes our views "cleaner" and more consistent
            @user.update_attributes(parameters)
            
          end
        end
        
  
    
        respond_to do |format|
          if @upload.save
          
            id = @upload[:id]
            post_path = Upload.copy( id, params[:upload], @current_date)
            if [ post_path ]
              flash[:notice] = 'Successfully Uploaded.'
              Emailer::deliver_mail(to_email, from_email, id, filename, @current_display_date, description)
              Fmailer::deliver_mail(to_email, from_email, id, filename, @current_display_date, description)
              
              format.html { redirect_to(@upload) }
              format.xml  { render :xml => @upload, :status => :created, :location => @upload }
            else
              flash[:notice] = 'File was unable to upload. Upload was unsuccessfully.'
            end        
          else
          
            #flash[:notice] = 'Kindly enter the file path correctly.'
          
           format.html { render :action => :index }
            format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
           #format.html { render :action => "index" }
           # format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
          end
        end
      elsif (arguments[:filename].size <= 999000000) and ( ! @current_user.nil?) 
  #    elsif arguments[:file].size <= 100000000
  #    if arguments[:file].size <= 000000
        @upload = Upload.new
        @upload[:ip] = request.remote_ip
        @upload[:permission] = arguments[:permission]
        #@upload[:data] = arguments[:file].read
        if !(arguments[:filename] == "" )
          filename = arguments[:filename].original_filename
          @upload[:filename] = filename
          @upload[:size] = arguments[:filename].size
          @upload[:description] = arguments[:description]
        end
  
        if !(arguments[:to_email] == "" )
          @upload[:to_email] = to_email
          if  @current_user
            @upload[:from_email] = @current_user.login
          else
            @upload[:from_email] = from_email
            
          end
        end
      
        if ! @current_user.nil?
	  from_email = @current_user.login
          @upload[:user_id] = @current_user.id
          @upload[:storage_type] = arguments[:storage_type]
          @upload[:access_mails] = arguments [:access_mails]
          if storage_type.to_i == 2
            parameters = Hash.new
            parameters[:used_space] = used_space
            @user = @current_user # makes our views "cleaner" and more consistent
            @user.update_attributes(parameters)
            
          end
        end
        
  
    
        respond_to do |format|
          if @upload.save
          
            id = @upload[:id]
            post_path = Upload.copy( id, params[:upload], @current_date)
            if [ post_path ]
              flash[:notice] = 'Successfully Uploaded.'
              Emailer::deliver_mail(to_email, from_email, id, filename, @current_display_date, description)
              #Fmailer::deliver_mail(to_email, from_email, id, filename, @current_display_date, description)
              
              format.html { redirect_to(@upload) }
              format.xml  { render :xml => @upload, :status => :created, :location => @upload }
            else
              flash[:notice] = 'File was unable to upload. Upload was unsuccessfully.'
            end        
          else
          
            #flash[:notice] = 'Kindly enter the file path correctly.'
          
           format.html { render :action => :index }
            format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
          end
        end
      elsif ((arguments[:filename].size <= 100000000) and ( @current_user.nil?) )
            flash[:notice] = 'Kindly register inorder to upload above 100MB file. Registration is 100% free.'
            redirect_to '/'
      else    
            redirect_to '/'
      end    
    else
      flash[:notice] = "Current file was unable to be uploaded because it crossed the permanent disk space limit. Your Permanent space usage is #{@current_user.used_space}."
      redirect_to '/'
    end
    
  #  render :text => "File has been uploaded successfully"
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    get_current_date
    current_user
    @user_session = UserSession.new
    @user = User.new

    @upload = Upload.find(params[:id])
    @download_url = params[:id].to_s + "_" + @upload[:filename].to_s.gsub(".","_") + "_" + @upload[:created_at].strftime("%Y_%m_%d")
    
    # send_file '/tmp/success.txt'
    #send_file '/tmp/success.txt'
    render :action => "show.html"    
  end
  
  
  def destroy
    get_current_date
    id = params[:id]
    @upload = Upload.find(id)
    if @current_user.id == @upload[:user_id]
      delete = Upload.delete_file( id, @upload[:created_at].strftime("%Y-%m-%d"))
      @upload.destroy
      if delete == true
        flash[:notice] = 'Your file has been successfully deleted. '
      end
    else
      flash[:notice] = 'You dont have permisssion to delete this file. '
    end
    
    redirect_to '/'

    
  end
  


 end
