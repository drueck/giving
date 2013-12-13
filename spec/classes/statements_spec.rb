require 'spec_helper'

describe Statements do

  before do
    @active_contributor = FactoryGirl.create(:contributor)
    FactoryGirl.create(:contribution, contributor: @active_contributor, date: Chronic.parse('7/22/2012'))
    FactoryGirl.create(:contribution, contributor: @active_contributor, date: Chronic.parse('7/22/2011'))

    @other_active_contributor = FactoryGirl.create(:contributor)
    FactoryGirl.create(:contribution, contributor: @other_active_contributor, date: Chronic.parse('7/22/2012'))

    @contributor_with_no_current_contributions = FactoryGirl.create(:contributor)
    FactoryGirl.create(:contribution, contributor: @contributor_with_no_current_contributions,
      date: Chronic.parse('1/4/2010'))

    @contributor_with_only_deleted_contributions = FactoryGirl.create(:contributor)
    FactoryGirl.create(:deleted_contribution, contributor: @contributor_with_only_deleted_contributions,
      date: Chronic.parse('1/1/2012'))

    @deleted_contributor = FactoryGirl.create(:deleted_contributor)
    FactoryGirl.create(:contribution, contributor: @deleted_contributor, date: Chronic.parse('1/1/2012'))

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
      contributors_ids.should include(@active_contributor.id)
      contributors_ids.should include(@other_active_contributor.id)
      contributors_ids.should_not include(@contributor_with_no_current_contributions.id)
      contributors_ids.should_not include(@contributor_with_only_deleted_contributions.id)
      contributors_ids.should_not include(@deleted_contributor.id)
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
