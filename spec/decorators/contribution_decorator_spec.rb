require 'spec_helper'

describe ContributionDecorator do

  describe "#date_string" do
    it "should return the contribution date formatted with M/D/YYYY" do
      date = Time.now
      expected_date_string = date.strftime("%m/%d/%Y")
      contribution = Contribution.new(date: date).decorate
      expect(contribution.date_string).to eq expected_date_string
    end
  end

end
