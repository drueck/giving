class ProfilesController < ApplicationController

  before_action :require_login

  respond_to :html, only: [:update]

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    respond_with @user, location: root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
