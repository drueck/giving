require 'spec_helper'

describe Contributor do

  describe "#mark_deleted" do

    before do
      @contributor = described_class.new
      @contributor.contributions << FactoryGirl.build(:contribution)
      @contributor.mark_deleted
    end

    it 'should set the contributor status to deleted' do
      @contributor.status.should eq 'Deleted'
    end

    it 'should set the status of related contributions to deleted' do
      @contributor.contributions.each do |contribution|
        contribution.status.should eq 'Deleted'
      end
    end

  end

  describe '#<=>' do

    before do
      @a = Contributor.create(name: 'a')
      @b = Contributor.create(name: 'b')
      @c = Contributor.create(name: 'c')
    end

    it 'compares contributors by name' do
      @a.should be < @b
      @b.should be < @c
    end

  end

end
