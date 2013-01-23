class Statements

  include Enumerable

  def initialize(year, options={})
    self.statement_class = options[:statement_class] || Statement
    self.year = year
    make_statements
  end

  def each(&blk)
    @statements.each(&blk)  
  end

  protected

  attr_accessor :year, :statement_class

  def make_statements
    @statements = []
    start_date = '1/1/' + year.to_s
    end_date = '12/31/' + year.to_s
    contributors = Contributor.joins(:posted_contributions)
      .where('contributions.date >= :start_date and contributions.date <= :end_date and contributions.status != :deleted',
        start_date: start_date, end_date: end_date, deleted: 'Deleted').order('last_name, first_name').uniq
    contributors.each do |contributor|
      @statements << statement_class.new(contributor, start_date, end_date)
    end
  end

end
