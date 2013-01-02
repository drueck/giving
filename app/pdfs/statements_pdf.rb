require 'prawn/measurement_extensions'

class StatementsPdf < Prawn::Document

  def initialize(statements)
    super(margin: 1.in, page_size: [8.5.in, 11.in])
    @statements = statements.to_a
    create_statements
  end

  def create_statements
    statements_count = @statements.length
    return if statements_count < 1
    add_statement @statements[0]
    if statements_count > 1
      (1..statements_count-1).each do |i|
        start_new_page
        add_statement @statements[i]
      end
    end
  end

  def add_statement(statement)
    contributor_name = statement.contributor.full_name
    start_date = format_date(statement.start_date)
    end_date = format_date(statement.end_date)
    text "Contributions by #{contributor_name}", size: 14, style: :bold
    text "#{start_date} to #{end_date}", size: 12
    add_contributions(statement)
  end

  def add_contributions(statement)
    move_down 15
    data = Array.new
    data << contributions_table_headings
    statement.contributions.each do |contribution|
      data << contribution_to_array(contribution)
    end
    total_contributions = number_to_currency(statement.total_contributions)
    data << [ { content: 'Total', colspan: 4 }, total_contributions ]  
    table(data) do |table|
      table.cells.size = 10
      table.cells.padding_left = 10
      table.cells.padding_right = 10
      table.cells.border_width = 0
      table.column(4).align = :right
      table.row(0).font_style = :bold
      table.row(-1).font_style = :bold
      table.row(-1).padding_top = 10
      table.position = :center
      table.width = 6.5.in
    end
  end

  def contributions_table_headings
    [ 'Contributor', 
      'Date',
      'Type',
      'Reference',
      'Amount' ]
  end

  def contribution_to_array(contribution)
    [ contribution.contributor.display_name,
      contribution.date_string,
      contribution.payment_type,
      contribution.reference,
      number_to_currency(contribution.amount) ]
  end

  protected

  def format_date(date)
    date_format = '%-m/%-d/%Y'
    Chronic.parse(date).strftime(date_format)
  end

  def number_to_currency(number)
    helper = Object.new.extend(ActionView::Helpers::NumberHelper)
    helper.number_to_currency(number)
  end

end
