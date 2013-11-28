class Statement

  include Comparable

  def initialize(contributor, start_date, end_date)
    @contributor = contributor
    @start_date = start_date
    @end_date = end_date
  end

  def <=>(other)
    self.contributor <=> other.contributor
  end

  attr_reader :contributor, :start_date, :end_date

  def contributions
    self.contributor.posted_contributions.where('date >= :start_date and date <= :end_date',
      start_date: start_date, end_date: end_date).order('date')
  end

  def total_contributions
    contributions.reduce(Money.new(0)) { |sum, c| sum += c.amount }
  end

end
