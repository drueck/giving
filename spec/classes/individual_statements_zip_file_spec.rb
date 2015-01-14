require "spec_helper"
require "zip"

describe IndividualStatementsZipFile do

  before(:each) do
    create(:contribution, date: "2014-05-01")
    create(:contribution, date: "2014-04-01")
    _wrong_year_contribution = create(:contribution, date: "2015-01-01")
    _no_contributions_contributor = create(:contributor)
  end

  describe "#path" do
    it "(creates and) returns the path of the zip file" do
      statements = Statements.new(2014)
      zipfile = described_class.new(statements)

      expect(File.exists?(zipfile.path)).to be_true

      Zip::File.open(zipfile.path) do |entries|
        expect(entries.count).to eq 2
        entries.each do |entry|
          expect(entry.size).to be > 0
        end
      end
    end
  end

end
