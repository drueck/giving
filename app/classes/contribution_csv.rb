class ContributionCSV < ModelCSV

  def initialize(contributions=Contribution.all)
    super(contributions.includes(:contributor))
  end

  private

  def column_headings
    [ "Contributor ID", "Contributor Name", "Contribution ID", "Date", "Payment Type",
      "Reference", "Amount" ]
  end

  def column_values(c)
    [ c.contributor_id, c.contributor.name, c.id, c.date, c.payment_type,
      c.reference, c.amount ]
  end

end
