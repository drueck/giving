class StatementsController < ApplicationController

  before_filter :require_login

  def new
    first_year = PostedContribution.minimum(:date).year
    last_year = PostedContribution.maximum(:date).year
    @years = (first_year..last_year).to_a.reverse
  end

  def create
    year = params[:year] || 2012
    message = params[:message] || ""
    statements = Statements.new(year)
    pdf = StatementsPdf.new(statements, message: message)
    options = {
      filename: "#{year}-statements.pdf",
      type: "application/pdf",
      disposition: 'inline'
    }
    send_data pdf.render, options
  end

end
