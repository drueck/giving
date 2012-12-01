class Contributor < ActiveRecord::Base

  attr_accessible :address, :city, :first_name, :last_name, :state, :zip, :household_name

  has_many :contributions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :household_name, presence: true

  before_validation :generate_household_name_if_needed

  def display_name
    last_name + ', ' + first_name
  end

  def full_name
    first_name + ' ' + last_name
  end

  def generate_household_name_if_needed
    if(first_name.present? && last_name.present? && household_name.blank?)
      self.household_name = first_name + ' ' + last_name
    end
  end

end
