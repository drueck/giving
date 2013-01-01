class Batch < ActiveRecord::Base

  has_many :contributions, conditions: "status != 'Deleted'"

  def total_contributions
    self.contributions.reduce(0) { |sum, c| sum += c.amount }
  end

  def posted_at_string
    self.posted_at.strftime("%B #{self.posted_at.day.ordinalize}, %Y %l:%M%P")
  end

end
