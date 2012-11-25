class UsersController < ApplicationController

  before_filter :require_admin_or_no_admins, only: [:new]

  def new
    @user = User.new
    if no_admins
      render :setup
    else
      render :new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_url, :notice => "Your account was created. Please login to continue."
    else
      if no_admins
        render :setup
      else
        render :new
      end
    end
  end

  def require_admin_or_no_admins
    unless no_admins
      require_login
      unless current_user_is_admin
        redirect_to root_url, notice: 'Only admins are allowed to manage users'
      end
    end
  end

end
