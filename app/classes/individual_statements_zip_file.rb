class IndividualStatementsZipFile

  def initialize(statements, message: "")
    @statements = statements
    @message = message
    @tempfiles = []
  end

  def path
    zipfile.path
  end

  private

  attr_reader :statements, :message, :tempfiles

  def zipfile
    @zipfile ||= build_zipfile
  end

  def build_zipfile
    Tempfile.new(["statements", ".zip"]).tap do |file|
      add_statements_to_zipfile(file)
    end
  end

  def add_statements_to_zipfile(file)
    Zip::File.open(file.path, Zip::File::CREATE) do |zip|
      statements.each do |statement|
        zip.add pretty_filename(statement), statement_file(statement).path
      end
    end
  ensure
    clean_up_tempfiles
  end

  def pretty_filename(statement)
    statement.contributor.name.downcase
      .gsub("&", "and")
      .gsub(/\s+/, "-")
      .gsub(/[^\w-]/, "") + ".pdf"
  end

  def statement_file(statement)
    new_statement_tempfile.tap { |f|
      f.write rendered_statement_pdf(statement)
      f.rewind
    }
  end

  def new_statement_tempfile
    Tempfile.new(["statement", ".pdf"]).tap { |file|
      file.binmode
      tempfiles.push(file)
    }
  end

  def rendered_statement_pdf(statement)
    StatementsPdf.new([statement], message: message)
      .render
  end

  def clean_up_tempfiles
    tempfiles.each do |file|
      file.unlink
    end
  end

end
