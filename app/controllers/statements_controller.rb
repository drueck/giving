class StatementsController < ApplicationController

  before_filter :require_login

  def new
  end

  def show
    year = params[:year]
    statements = Statements.new(year)
    respond_to do |format|
      format.pdf {
        pdf = StatementsPdf.new(statements)
        options = {
          filename: "#{year}-statements.pdf",
          type: "application/pdf"
        }
        if(params[:d] == 'inline') 
          options.store(:disposition, 'inline')
        end
        send_data pdf.render, options
      }
    end
  end

end
