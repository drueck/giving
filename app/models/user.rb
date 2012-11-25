class User < ActiveRecord::Base

  authenticates_with_sorcery!
  
  attr_accessible :username, :password, :password_confirmation, :user_type

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  validates :user_type, presence: true

  validate :user_type_is_valid

  def self.user_types
    ['Standard', 'Admin']
  end

  def self.default_user_type
    'Standard'
  end

  def self.admin_user_type
    'Admin'
  end

  def is_admin
    user_type == 'Admin'
  end

  def user_type_is_valid
    unless self.class.user_types.include?(user_type)
      errors.add(:user_type,'is invalid')
    end
  end

end
