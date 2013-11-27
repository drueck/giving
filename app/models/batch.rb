class Batch < ActiveRecord::Base

  has_many :contributions, -> { where.not(status: "Deleted") }

  def total_contributions
    self.contributions.reduce(Money.new(0)) { |sum, c| sum += c.amount }
  end

  def posted_at_string
    self.posted_at.strftime("%B #{self.posted_at.day.ordinalize}, %Y %l:%M%P")
  end

end
