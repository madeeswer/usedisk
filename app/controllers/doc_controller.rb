class DocController < ApplicationController
  def load
    current_user
    id = params[:id]
    
    @user_session = UserSession.new
    @user = User.new
    @image_id = session.id.to_s.slice(1,5)
    
    render :action => "#{id}.html"
  end
end
