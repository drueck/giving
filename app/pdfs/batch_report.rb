class BatchReport < Prawn::Document

  def initialize(batch)
    super()
    @batch = batch
    create_report
  end

  def create_report
    title
    contributions
    total
  end

  def title
    text "Batch #{@batch.id}, Posted #{@batch.posted_at_string}", size: 16, align: :center, style: :bold
  end

  def contributions 
    move_down 15
    data = Array.new
    data << contributions_table_headings
    @batch.contributions.order('date, id').each do |contribution|
      data << contribution_to_array(contribution)
    end  
    table(data) do 
      cells.padding_left = 10
      cells.padding_right = 10
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

  def total 
    move_down 15
    total_contributions = number_to_currency(@batch.total_contributions)
    text "Total: #{total_contributions}", size: 14
  end

  def number_to_currency(number)
    helper = Object.new.extend(ActionView::Helpers::NumberHelper)
    helper.number_to_currency(number)
  end

end
