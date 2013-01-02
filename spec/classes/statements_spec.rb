require 'spec_helper'

describe Statements do

  before do
    @contributor1 = FactoryGirl.create(:contributor)
    2.times { FactoryGirl.create(:posted_contribution, contributor: @contributor1, date: Chronic.parse('7/22/2012')) }
    FactoryGirl.create(:posted_contribution, contributor: @contributor1, date: Chronic.parse('7/22/2011'))
    
    @contributor2 = FactoryGirl.create(:contributor)
    2.times { FactoryGirl.create(:posted_contribution, contributor: @contributor2, date: Chronic.parse('7/22/2012')) }
    FactoryGirl.create(:posted_contribution, contributor: @contributor2, date: Chronic.parse('7/22/2011'))
    
    @contributor3 = FactoryGirl.create(:contributor)
    FactoryGirl.create(:posted_contribution, contributor: @contributor3, date: Chronic.parse('1/4/2010'))

    @contributor4 = FactoryGirl.create(:contributor)
    deleted_contribution = FactoryGirl.create(:posted_contribution, contributor: @contributor4, date: Chronic.parse('1/1/2012'))
    deleted_contribution.destroy

    @year = 2012
    @statements = Statements.new(@year)
  end

  describe '#each' do

    it 'should yield a statement for each contributor with at least one non-deleted contribution during the year' do
      statements = []
      @statements.each do |statement|
        statements << statement
      end
      statements.length.should eq 2
      contributors_ids = statements.map { |st| st.contributor.id }
      contributors_ids.should include(@contributor1.id)
      contributors_ids.should include(@contributor2.id)
      contributors_ids.should_not include(@contributor3.id)
    end

    context 'and each statement' do
      
      it 'should have a start date of the first day of the specified year' do
        Chronic.parse(@statements.first.start_date).should eq Chronic.parse('1/1/' + @year.to_s)
      end

      it 'should have an end date of the last day of the specified year' do
        Chronic.parse(@statements.first.end_date).should eq Chronic.parse('12/31/' + @year.to_s)
      end

    end     

  end

end
