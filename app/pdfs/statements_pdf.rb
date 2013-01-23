require 'prawn/measurement_extensions'

class StatementsPdf < Prawn::Document

  def initialize(statements, options={})
    super()
    self.statements = statements.try(:to_a) || []
    self.organization = options[:organization] || Organization.first || Organization.new
    self.message = options[:message] || ""
    add_statements
  end

  def add_statements
    statements_count = statements.length
    return if statements_count < 1

    add_statement statements[0] 

    if statements_count > 1
      statements[1..statements_count-1].each do |statement|
        start_new_page
        add_statement statement
      end
    end

    add_page_footers
  end

  def add_statement(statement)
    pages = paginate_data(statement)
    last_page_index = pages.length - 1
    pages.each_index do |page_index|
      start_new_page unless page_index == 0
      add_statement_page(statement, pages[page_index], last_page: page_index == last_page_index) 
    end
  end

  def add_statement_page(statement, data, options={})
    last_page = options[:last_page] || false
    add_page_header(statement)
    move_down 0.4.in
    output_table(data, contains_total_row: last_page)
    if last_page
      if room_for_report_footer
        add_report_footer
      else
        start_new_page
        add_report_footer_only_page(statement)
      end
    end
  end

  def room_for_report_footer
    cursor - 0.25.in - height_of(report_footer_content) > 0.75.in
  end

  def add_report_footer_only_page(statement)
    add_page_header(statement)
    move_down 0.4.in
    add_report_footer
  end

  def add_page_header(statement)
    move_down 0.25.in
    add_return_address_block
    add_heading(statement)
    add_contributor_address_block(statement)
  end

  def add_return_address_block
    lines = organization_address_lines
    text lines[0], style: :bold unless lines.length < 1
    if lines.length > 1
      lines[1..lines.length-1].each do |line| 
        text line
      end
    end
  end

  def add_heading(statement)
    move_down 0.25.in
    contributor_name = statement.contributor.full_name
    start_date = format_date(statement.start_date)
    end_date = format_date(statement.end_date)
    text "Contributions by #{contributor_name}", size: 14, style: :bold, align: :center
    text "#{start_date} to #{end_date}", size: 12, align: :center
  end

  def add_contributor_address_block(statement)
    move_down 0.25.in
    indent(0.5.in) do
      contributor = statement.contributor
      text contributor.household_name, style: :bold
      text contributor.address
      text "#{contributor.city}, #{contributor.state} #{contributor.zip}"
    end
  end

  def paginate_data(statement)
    data = Array.new
    paginated_data = Array.new
    statement.contributions.each do |contribution|
      data << contribution_to_array(contribution)
    end
    page_numbers = (1..(data.length / contributions_per_page)+1).to_a
    page_numbers.each do |page_number|
      paginated_data << get_data_rows(data, page_number)
    end
    paginated_data[page_numbers.length-1] = paginated_data[page_numbers.length-1] + [get_total_row(statement)]
    paginated_data
  end

  def get_data_rows(data, page_number)
    [contributions_table_headings] + 
      data[((page_number-1)*contributions_per_page)..((page_number*contributions_per_page)-1)]
  end

  def get_total_row(statement)
    total_contributions = number_to_currency(statement.total_contributions)
    total_row = [ { content: 'Total', colspan: 4 }, total_contributions ]  
    total_row
  end

  def output_table(data, options={})
    contains_total_row = options[:contains_total_row] || false
    table(data, header: true) do |table|
      table.cells.size = 10
      table.cells.padding_left = 10
      table.cells.padding_right = 10
      table.cells.padding_top = 2
      table.cells.padding_bottom = 2
      table.column(0).padding_left = 0
      table.column(-1).padding_right = 0
      table.cells.border_width = 0
      table.column(4).align = :right
      table.row(0).font_style = :bold
      table.row(0).borders = [:bottom]
      table.row(0).border_width = 1
      table.row(1).padding_top = 15
      if contains_total_row
        table.row(-1).font_style = :bold
        table.row(-1).padding_top = 10
      end
      table.position = :center
      table.width = 7.5.in
    end
  end

  def add_report_footer
    move_down 0.25.in
    text report_footer_content
  end

  def add_page_footers
    repeat :all do
      bounding_box [bounds.left, bounds.bottom + 0.5.in], width: bounds.width do
        stroke_horizontal_rule
        move_down 5
        text page_footer_content, size: 10
      end
    end
  end

  def contributions_table_headings
    [ 'Contributor', 
      'Date Recorded',
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

  attr_accessor :statements, :organization, :message

  def contributions_per_page
    27
  end

  def organization_address_lines
    organization.address_lines
  end

  def page_footer_content
    'Pursuant to Internal Revenue Code requirements for substantiation of charitable contributions, ' +
    'no goods or services were provided in return for these contributions.'
  end

  def report_footer_content
    message
  end

  def format_date(date)
    date_format = '%-m/%-d/%Y'
    Chronic.parse(date).strftime(date_format)
  end

  def number_to_currency(number)
    helper = Object.new.extend(ActionView::Helpers::NumberHelper)
    helper.number_to_currency(number)
  end

end
