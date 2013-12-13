require 'spec_helper'

describe Contribution do

  describe ".year_range" do
    before(:each) do
      min_year = rand(1980..1989)
      max_year = rand(1990..1999)
      @expected_range = min_year..max_year
      FactoryGirl.create(:contribution, date: "1/1/#{min_year}")
      FactoryGirl.create(:contribution, date: "1/1/#{max_year}")
    end
    it "should return the range of all years that have contributions" do
      expect(described_class.year_range).to eq @expected_range
    end
  end

  describe "mark_deleted" do
    before(:each) do
      @contribution = FactoryGirl.build(:contribution)
      expect(@contribution).not_to be_persisted
      expect(@contribution.status).not_to eq "Deleted"
    end
    it "should set the status to 'Deleted' and save the record" do
      @contribution.mark_deleted
      expect(@contribution).to be_persisted
      expect(@contribution.status).to eq "Deleted"
    end
  end

end
