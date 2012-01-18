# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
    helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  
  
  
  def get_current_date
    return @current_date if defined?(@current_date)
      @current_date = Date.today.strftime('%Y-%m-%d')
      @current_display_date = Date.today.strftime('%Y_%m_%d')
  end
  
      def rescue_404
        rescue_action_in_public(ActionController::RoutingError)
      end
      
      def rescue_action_in_public(exception)
        #maybe gather up some data you'd want to put in your error page
      
        case exception
          when ActionController::InvalidAuthenticityToken
          when ArgumentError
          when SyntaxError
            render :file => "/500.html", :layout => "error", :status => "500"
          else
            render :file => "/404.html", :layout => "error", :status => "404"
        end          
      end
    
      def local_request?
        return false
      end
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '29a3c9e7f2743dbcbf98c077633eed6b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
