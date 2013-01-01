require 'spec_helper'

describe Batch do

  context 'with some contributions and some deleted contributions' do

    before :each do
      contributor = FactoryGirl.create(:contributor)
      @contribution = FactoryGirl.create(:posted_contribution, contributor: contributor)
      @deleted_contribution = FactoryGirl.create(:posted_contribution, contributor: contributor)
      batch = Batch.new
      batch.contributions << @contribution
      batch.contributions << @deleted_contribution
      batch.posted_at = Time.now
      batch.save.should_not eq false
      batch.contributions.length.should eq 2
      @deleted_contribution.destroy
      Contribution.find(@deleted_contribution.id).id.should eq @deleted_contribution.id
      @batch_id = batch.id
    end

    describe '#contributions' do
      
      it 'should return all non-deleted contributions on this batch' do
        batch = Batch.find(@batch_id)
        batch.contributions.length.should eq 1
        batch.contributions.map { |c| c.id }.should include(@contribution.id) 
        batch.contributions.map { |c| c.id }.should_not include(@deleted_contribution.id)
      end  

    end 

    describe '#total_contributions' do

      before do
        contributor = FactoryGirl.create(:contributor)
        @contribution2 = FactoryGirl.create(:posted_contribution, contributor: contributor)
        batch = Batch.find(@batch_id)
        batch.contributions << @contribution2
        batch.save.should_not eq false
      end

      it 'should return the sum of the amounts of non-deleted contributions on this batch' do
        total_amount = @contribution.amount + @contribution2.amount
        batch = Batch.find(@batch_id)
        batch.total_contributions.should eq total_amount
      end

    end

  end


end
