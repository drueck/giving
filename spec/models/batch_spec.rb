require 'spec_helper'

describe Batch do

  describe "#mark_deleted" do

    before do
      @batch = described_class.new
      @batch.contributions << FactoryGirl.build(:contribution)
      @batch.mark_deleted
    end

    it 'should set the batch status to deleted' do
      @batch.status.should eq 'Deleted'
    end

    it 'should set the status of related contributions to deleted' do
      @batch.contributions.each do |contribution|
        contribution.status.should eq 'Deleted'
      end
    end

  end

  context 'with some contributions and some deleted contributions' do

    before :each do
      contributor = FactoryGirl.create(:contributor)
      @contribution = FactoryGirl.create(:contribution, contributor: contributor)
      @deleted_contribution = FactoryGirl.create(:deleted_contribution, contributor: contributor)
      batch = Batch.new
      batch.contributions << @contribution
      batch.contributions << @deleted_contribution
      batch.save.should_not eq false
      expect(Contribution.unscoped.count).to eq 2
      @batch_id = batch.id
    end

    describe '#contributions' do

      it 'should return all non-deleted contributions on this batch' do
        batch = Batch.find(@batch_id)
        batch.contributions.length.should eq 1
        batch.contributions.pluck(:id).should include(@contribution.id)
        batch.contributions.pluck(:id).should_not include(@deleted_contribution.id)
      end

    end

    describe '#total_contributions' do

      before do
        contributor = FactoryGirl.create(:contributor)
        @contribution2 = FactoryGirl.create(:contribution, contributor: contributor)
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
