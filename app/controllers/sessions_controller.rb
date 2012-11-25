class SessionsController < ApplicationController

  def new
    if no_admins
      redirect_to new_user_url
    end
  end
  
  def create
    user = login(params[:username], params[:password])
    if user
      redirect_back_or_to root_url, :notice => "Logged in"
    else
      flash.now.alert = "Username or password was invalid"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "Logged out"
  end

end
