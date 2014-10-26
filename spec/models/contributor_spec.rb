require 'spec_helper'

describe Contributor do

  describe "#valid?" do
    it "dissallows duplicate names for active contributors" do
      active_joe = Contributor.create(name: "Joe", status: "Active")
      new_joe = Contributor.new(name: "Joe")
      expect(new_joe.valid?).to be_false
      expect(new_joe.errors[:name]).not_to be_empty
    end
    it "allows duplicate contributor names if the duplicates have been deleted" do
      deleted_joe = Contributor.create(name: "Joe", status: "Deleted")
      new_joe = Contributor.new(name: "Joe")
      expect(new_joe.valid?).to be_true
    end
  end

  describe "#name_search" do
    before(:each) do
      @contributor = FactoryGirl.create(:contributor, first_name: "abc d efg",
        last_name: "hi jk", name: "lmno")
      expect(@contributor).to be_persisted
    end
    context "when the query is empty" do
      it "should return all contributors" do
        expect(described_class.name_search("")).to include(@contributor)
      end
    end
    context "when a contributor's first name matches any full words from the query string" do
      it "should return that contributor among the results" do
        expect(described_class.name_search("abc efg")).to include(@contributor)
        expect(described_class.name_search("ab")).not_to include(@contributor)
      end
    end
    context "when a contributor's last name matches any full words from the query string" do
      it "should return that contributor among the results" do
        expect(described_class.name_search("hi")).to include(@contributor)
        expect(described_class.name_search("j")).not_to include(@contributor)
      end
    end
    context "when a contributor's (full) name matches any full words from the query string" do
      it "should return that contributor among the results" do
        expect(described_class.name_search("lmno")).to include(@contributor)
        expect(described_class.name_search("mn")).not_to include(@contributor)
      end
    end
  end

  describe "#mark_deleted" do

    before do
      @contributor = FactoryGirl.create(:contributor)
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
