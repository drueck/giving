class SessionsController < ApplicationController

  def new
    if no_admins?
      redirect_to new_user_url
    end
  end

  def create
    user = login(params[:session][:username], params[:session][:password])
    if user
      redirect_back_or_to root_url
    else
      flash.now.alert = "Username or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

end
