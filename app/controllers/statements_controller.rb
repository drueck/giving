require 'zip'

class StatementsController < ApplicationController

  before_action :require_login

  def new
    load_years
  end

  def create
    if contributions_exist_for?(year)
      respond_with_statements
    else
      render_new_with_warning
    end
  end

  private

  def load_years
    @years = (Contribution.year_range).to_a.reverse
  end

  def contributions_exist_for?(year)
    in_specified_year = "#{year}-01-01".."#{year}-12-31"
    Contribution.where(date: in_specified_year).exists?
  end

  def respond_with_statements
    if output_type == "many"
      send_zip_of_individual_statements
    else
      send_pdf_of_all_statements
    end
  end

  def send_pdf_of_all_statements
    statements = Statements.new(year)
    pdf = StatementsPdf.new(statements, message: message)
    options = {
      filename: "#{year}-statements.pdf",
      type: "application/pdf"
    }
    send_data(pdf.render, options)
  end

  def send_zip_of_individual_statements
    statements = Statements.new(year)
    zipfile = IndividualStatementsZipFile.new(statements, message: message)
    File.open(zipfile.path, "r") do |f|
      send_data(f.read.force_encoding("BINARY"),
                filename: "#{year}-statements.zip",
                type: "application/zip")
    end
  ensure
    File.unlink(zipfile.path)
  end

  def render_new_with_warning
    flash.now[:warning] = "No contributions were found for #{year}"
    load_years
    render :new
  end

  def year
    @year ||= params.fetch(:year) { Time.now.year }
  end

  def message
    @message ||= params.fetch(:message) { "" }
  end

  def output_type
    @output_type ||= params.fetch(:output_type) { "one" }
  end

end
