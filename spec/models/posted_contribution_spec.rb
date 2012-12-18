require 'spec_helper'

describe PostedContribution do

  describe '#new' do

    it "should set the status to 'Posted'" do
      contribution = FactoryGirl.build(:posted_contribution)
      contribution.status.should eq 'Posted'
    end

  end

  describe '#destroy' do

    before do
      contributor = FactoryGirl.create(:contributor)
      @contribution = FactoryGirl.build(:posted_contribution, contributor: contributor)
      @contribution.destroy
    end

    it "should set the status to 'Deleted'" do
      @contribution.status.should eq 'Deleted'
    end

    it 'should save the record' do
      @contribution.id.should_not be_nil
    end

  end

end
