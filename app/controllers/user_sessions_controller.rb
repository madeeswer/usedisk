class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    @user = User.new
    @image_id = session.id.to_s.slice(1,5)


  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    @user = User.new
    
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to '/uploads'
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to '/uploads'
  end
end
