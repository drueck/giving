class User < ActiveRecord::Base

  STANDARD_USER_TYPE = "Standard"
  ADMIN_USER_TYPE = "Admin"
  USER_TYPES = [ STANDARD_USER_TYPE, ADMIN_USER_TYPE ]
  DEFAULT_USER_TYPE = STANDARD_USER_TYPE

  authenticates_with_sorcery!

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  validates :user_type, presence: true

  validate :user_type_is_valid

  def admin?
    user_type == ADMIN_USER_TYPE
  end

  def user_type_is_valid
    unless USER_TYPES.include?(user_type)
      errors.add(:user_type, "is invalid")
    end
  end

end
