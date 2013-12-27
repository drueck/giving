class StatementsController < ApplicationController

  before_action :require_login

  def new
    @years = (Contribution.year_range).to_a.reverse
  end

  def create
    year = params[:year] || Time.now.year
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
