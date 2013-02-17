class Contributor < ActiveRecord::Base

  include Comparable

  attr_accessible :address, :city, :first_name, :last_name, :state, :zip, :household_name, :phone, :email

  has_many :posted_contributions, dependent: :destroy

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

  def <=>(other)
    result = last_name <=> other.last_name
    if result == 0
      result = first_name <=> other.first_name
    end
    result
  end

  def self.names_search(query)
    if query.present?
      where("first_name @@ :q or last_name @@ :q or household_name @@ :q", q: query)
    else
      scoped
    end
  end

  protected

  def generate_household_name_if_needed
    if(first_name.present? && last_name.present? && household_name.blank?)
      self.household_name = first_name + ' ' + last_name
    end
  end

end
