class ContributorCSV < ModelCSV

  def initialize(contributors=Contributor.all)
    super(contributors)
  end

  private

  def column_headings
    [ "id", "Name", "First Name", "Last Name", "Address", "City", "State", "Zip",
      "Phone", "Email", "Notes" ]
  end

  def column_values(c)
    [ c.id, c.name, c.first_name, c.last_name, c.city, c.state, c.zip,
      c.phone, c.email, c.notes ]
  end

end
