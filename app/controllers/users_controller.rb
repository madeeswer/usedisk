class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
    @user_session = UserSession.new
    @image_id = session.id.to_s.slice(1,5)

    
  end
  
  def create
    get_current_date
    user = params[:user]
    captcha = user[:captcha]
    @image_id = params[:session_id].to_s.slice(1,5)

    url = URI.parse('http://captchator.com/')

    @res = Net::HTTP.start(url.host, url.port) {|http|
      http.get('/captcha/check_answer/' + @image_id.to_s + '/' + captcha)
    }
    if /1/.match(@res.body)
    activation = rand(1000000)
    @user = User.new(params[:user])
    @user_session = UserSession.new
    @user[:activation] = activation

    if @user.save
      id = @user[:id]
      flash[:notice] = "Account registered!"
#      redirect_back_or_default account_url
      redirect_to '/'
    else
      render :action => :new
    end
    else
    flash[:notice] = "For registration, kindly Type the correct letters present in the picture."
      redirect_to '/account/new'
    end    
  end
  
  def show
    @user = @current_user

    redirect_to "user_uploads"
    
  end
 
  def edit
    @user = @current_user

  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
