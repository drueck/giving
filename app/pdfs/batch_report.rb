class BatchReport < Prawn::Document

  def initialize(batch)
    super()
    @batch = batch
    create_report
  end

  def create_report
    title
    contributions
  end

  def title
    move_down inches_to_pdf_points(0.25)
    text "Batch #{@batch.id}, Posted #{@batch.posted_at_string}", size: 14, align: :center, style: :bold
  end

  def contributions 
    move_down 15
    data = Array.new
    data << contributions_table_headings
    @batch.contributions.order('date, id').each do |contribution|
      data << contribution_to_array(contribution)
    end
    total_contributions = number_to_currency(@batch.total_contributions)
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
      table.width = inches_to_pdf_points(7)
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

  def number_to_currency(number)
    helper = Object.new.extend(ActionView::Helpers::NumberHelper)
    helper.number_to_currency(number)
  end

  def inches_to_pdf_points(inches)
    inches * 72
  end
  protected :inches_to_pdf_points

end
