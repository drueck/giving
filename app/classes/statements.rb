class Statements

  include Enumerable

  def initialize(year, options={})
    @statement_class = options[:statement_class] || Statement
    @year = year
  end

  def each(&blk)
    statements.each(&blk)
  end

  private

  attr_reader :year, :statement_class, :statements

  def statements
    @statements ||=
      contributors.map { |contributor| statement_for(contributor) }
  end

  def contributors
    Contributor.joins(:contributions)
      .where('contributions.date >= :start_date and '\
             'contributions.date <= :end_date and '\
             'contributions.status != :deleted',
             start_date: start_date, end_date: end_date,
             deleted: 'Deleted').order('name').uniq
  end

  def statement_for(contributor)
    statement_class.new(contributor, start_date, end_date)
  end

  def start_date
    '1/1/' + year.to_s
  end

  def end_date
    '12/31/' + year.to_s
  end

end
