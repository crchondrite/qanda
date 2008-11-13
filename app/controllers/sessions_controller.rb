class SessionsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def new
  end

  def create
    if using_open_id?
      open_id_authentication
    else
      render :action => :new
    end
  end

  protected
  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        session[:identity_url] = identity_url
        redirect_to(root_url)
      else
        flash[:error] = result.message
        redirect_to(new_session_url)
      end
    end
  end
end
