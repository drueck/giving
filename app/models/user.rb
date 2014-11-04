class User < ActiveRecord::Base

  STANDARD = "Standard"
  ADMIN = "Admin"
  USER_TYPES = [ STANDARD, ADMIN ]
  DEFAULT_USER_TYPE = STANDARD

  authenticates_with_sorcery!

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates_confirmation_of :password, if: -> { password.present? }
  validates :user_type, presence: true

  validate :user_type_is_valid

  def admin?
    user_type == ADMIN
  end

  def user_type_is_valid
    unless USER_TYPES.include?(user_type)
      errors.add(:user_type, "is invalid")
    end
  end

end
