class ContributionDecorator < Draper::Decorator

  delegate_all

  def date_string
    date.nil? ? "" : date.strftime("%m/%d/%Y")
  end

end
