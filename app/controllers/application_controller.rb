class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_footer

      def get_footer
      	if Update.exists?
      		@last_update = Update.last.created_at
      	else
      		@last_update = "1999-01-01 00:00:00"
      	end
        
      end

end