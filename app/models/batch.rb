class Batch < ActiveRecord::Base

  default_scope { where.not(status: "Deleted") }

  has_many :contributions

  def total_contributions
    self.contributions.reduce(Money.new(0)) { |sum, c| sum += c.amount }
  end

  def mark_deleted
    self.class.transaction do
      mark_contributions_deleted
      mark_self_deleted
      save
    end
  end

  private

  def mark_self_deleted
    self.status = "Deleted"
  end

  def mark_contributions_deleted
    contributions.each do |contribution|
      contribution.mark_deleted
    end
  end

end
