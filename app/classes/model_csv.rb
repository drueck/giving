require 'csv'

class ModelCSV

  def initialize(records)
    @records = records
  end

  def generate(options={})
    CSV.generate(options) do |csv|
      csv << column_headings
      records.each do |record|
        csv << column_values(record)
      end
    end
  end

  private

  attr_reader :records

  def column_headings
    []
  end

  def column_values(record)
    []
  end

end
