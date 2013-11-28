require 'spec_helper'

describe Statement do

  context 'when initialized with a valid contributor and valid start and end dates as Strings' do

    before do
      @contributor = FactoryGirl.create(:contributor)
      @start_date = '1/1/2012'
      @end_date = '12/31/2012'
      @statement = Statement.new(@contributor, @start_date, @end_date)
      @included_contribution = FactoryGirl.create(:posted_contribution, contributor: @contributor, date: Chronic.parse('7/22/2012'))
      @excluded_contribution = FactoryGirl.create(:posted_contribution, contributor: @contributor, date: Chronic.parse('7/22/2011'))
      @deleted_contribution = FactoryGirl.create(:posted_contribution, contributor: @contributor, date: Chronic.parse('1/1/2012'))
      @deleted_contribution.destroy
    end

    describe '#contributor' do
      it 'should return the contributor' do
        @statement.contributor.should eq @contributor
      end
    end

    describe '#start_date' do
      it 'should return the start date' do
        @statement.start_date.should eq @start_date
      end
    end

    describe '#end_date' do
      it 'should return the end date' do
        @statement.end_date.should eq @end_date
      end
    end

    describe '#contributions' do
      it 'should include only posted, non-deleted contributions for the given contributor in the given date range' do
        @statement.contributions.should include(@included_contribution)
        @statement.contributions.should_not include(@excluded_contribution)
        @statement.contributions.should_not include(@deleted_contribution)
      end
    end

    describe '#total_contributions' do
      it 'should return the total of all the contribution amounts on the statement' do
        total_amount = @statement.contributions.reduce(Money.new(0)) { |sum, c| sum += c.amount }
        @statement.total_contributions.should eq total_amount
      end
    end

  end

  context 'when initialized with a valid contributor and valid start and end dates as Dates' do

    before do
      @contributor = FactoryGirl.create(:contributor)
      @start_date = Chronic.parse('1/1/2012').to_date
      @end_date = Chronic.parse('12/31/2012').to_date
      @statement = Statement.new(@contributor, @start_date, @end_date)
      @included_contribution = FactoryGirl.create(:posted_contribution, contributor: @contributor, date: Chronic.parse('7/22/2012'))
      @excluded_contribution = FactoryGirl.create(:posted_contribution, contributor: @contributor, date: Chronic.parse('7/22/2011'))
    end

    describe '#contributor' do
      it 'should return the contributor' do
        @statement.contributor.should eq @contributor
      end
    end

    describe '#start_date' do
      it 'should return the start date' do
        @statement.start_date.should eq @start_date
      end
    end

    describe '#end_date' do
      it 'should return the end date' do
        @statement.end_date.should eq @end_date
      end
    end

    describe '#contributions' do
      it 'should include only posted contributions for the given contributor in the given date range' do
        @statement.contributions.should include(@included_contribution)
        @statement.contributions.should_not include(@excluded_contribution)
      end
    end

  end

end
