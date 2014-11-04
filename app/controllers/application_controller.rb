class ApplicationController < ActionController::Base

  protect_from_forgery

private

  def current_user_is_admin?
    current_user && current_user.admin?
  end
  helper_method :current_user_is_admin?

  def no_admins?
    User.where(user_type: User::ADMIN).count.zero?
  end

  def not_authenticated
    if no_admins?
      redirect_to new_user_url
    else
      redirect_to login_url
    end
  end

end
