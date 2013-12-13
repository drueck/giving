class UsersController < ApplicationController

  before_action :require_admin_or_no_admins

  def index
    @users = User.all
      .order('username')
      .paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
    if no_admins?
      render :setup
    else
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if current_user
        redirect_to users_url
      else
        redirect_to login_url, :notice => "Your account was created. Please login to continue."
      end
    else
      if no_admins?
        render :setup
      else
        render :new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_url
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.id == @user.id
      flash.now[:notice] << 'Cannot delete current user'
      render :edit
    else
      @user.destroy
      redirect_to users_url, notice: 'User deleted'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password,
      :password_confirmation, :user_type)
  end

  def require_admin_or_no_admins
    require_admin unless no_admins?
  end

  def require_admin
    require_login and return
    unless current_user_is_admin?
      redirect_to root_url, notice: 'Only admins are allowed to manage users'
    end
  end

end
