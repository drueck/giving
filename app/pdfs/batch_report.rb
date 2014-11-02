require "prawn/measurement_extensions"

class BatchReport < Prawn::Document

  def initialize(batch)
    super()
    @batch = batch.decorate
    create_report
  end

  def create_report
    title
    contributions
    notes
  end

  def title
    move_down 0.25.in
    text "#{@batch.title}, Posted #{@batch.created_at_string}", size: 14, align: :center, style: :bold
  end

  def contributions
    move_down 15
    table(contributions_data) do |table|
      table.cells.size = 10
      table.cells.padding_left = 10
      table.cells.padding_right = 10
      table.cells.border_width = 0
      table.column(4).align = :right
      table.column(0).padding_left = 0
      table.column(4).padding_right = 0
      table.row(0).font_style = :bold
      table.row(-1).font_style = :bold
      table.row(-1).padding_top = 10
      table.position = :center
      table.width = 7.5.in
    end
  end

  def contributions_data
    data = [ contributions_table_headings ]
    data += contributions_table_body
    data << contributions_table_totals
  end

  def contributions_table_headings
    [ 'Contributor',
      'Date',
      'Type',
      'Reference',
      'Amount' ]
  end

  def contributions_table_body
    @batch.contributions.order('date, id').decorate.map { |contribution|
      contribution_to_array(contribution)
    }
  end

  def contributions_table_totals
    total_contributions = number_to_currency(@batch.total_contributions)
    [ { content: 'Total', colspan: 4 }, total_contributions ]
  end

  def contribution_to_array(contribution)
    [ contribution.contributor.name,
      contribution.date_string,
      contribution.payment_type,
      contribution.reference,
      number_to_currency(contribution.amount) ]
  end

  def notes
    move_down 0.25.in
    text "Notes", size: 10, style: :bold
    move_down 0.1.in
    text @batch.notes, size: 10
  end

  def number_to_currency(number)
    helper = Object.new.extend(ActionView::Helpers::NumberHelper)
    helper.number_to_currency(number)
  end

end
