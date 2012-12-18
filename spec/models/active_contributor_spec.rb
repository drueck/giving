require 'spec_helper'

describe ActiveContributor do

  describe '#new' do

    it "should set the status to 'Active'" do
      contributor = ActiveContributor.new
      contributor.status.should eq 'Active'
    end

  end

  describe '#destroy' do

    before do
      @contributor = ActiveContributor.new
      @contributor.posted_contributions << PostedContribution.new
      @contributor.posted_contributions << PostedContribution.new
      @contributor.destroy
    end

    it 'should set the contributor status to deleted' do 
      @contributor.status.should eq 'Deleted'
    end

    it 'should set the status of related contributions to deleted' do
      @contributor.posted_contributions.each do |contribution|
        contribution.status.should eq 'Deleted'
      end
    end

  end

end
