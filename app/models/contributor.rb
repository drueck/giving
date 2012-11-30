class Contributor < ActiveRecord::Base

  attr_accessible :address, :city, :first_name, :last_name, :state, :zip

  has_many :contributions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def display_name
    last_name + ', ' + first_name
  end

  def full_name
    first_name + ' ' + last_name
  end

end
