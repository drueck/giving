class Contribution < ActiveRecord::Base

  belongs_to :contributor
  belongs_to :batch

  monetize :amount_cents

  validates :contributor_id, presence: true
  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  def self.year_range
    this_year = Time.now.year
    first_year = minimum(:date).try(:year) || this_year
    last_year = maximum(:date).try(:year) || this_year
    first_year..last_year
  end

  def date_string
    date.nil? ? "" : date.strftime("%m/%d/%Y")
  end

end
