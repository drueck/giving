require 'spec_helper'

describe PendingContribution do

  describe '#new' do

    it "should set the status to 'Pending'" do
      contribution = FactoryGirl.build(:pending_contribution)
      contribution.status.should eq 'Pending'
    end

  end

  describe '#destroy' do

    before do
      contributor = FactoryGirl.create(:contributor)
      @contribution = FactoryGirl.build(:pending_contribution, contributor: contributor)
      @contribution.save
    end

    it 'should delete the record' do
      id = @contribution.id
      @contribution.destroy
      Contribution.where(id: id).length.should eq 0
    end

  end

end
