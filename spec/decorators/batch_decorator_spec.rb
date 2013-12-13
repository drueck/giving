require 'spec_helper'

describe BatchDecorator do

  describe "#title" do

    context "when there is no name" do
      it "should return a title using the batch id" do
        expect(Batch.new(id: 2).decorate.title).to eq "Batch 2"
      end
    end

    context "when a name is present" do
      it "should return that name" do
        expect(Batch.new(id: 2, name: "My Batch").decorate.title).to eq "My Batch"
      end
    end

  end

  describe "#created_at_string" do

    context "when the created_at date is nil" do
      it "should return an empty string" do
        expect(Batch.new.decorate.created_at_string).to eq ""
      end
    end

    context "when the created_at date is a valid time" do
      it "should return a string with the expected date and time formatting" do
        batch = Batch.new(created_at: Chronic.parse("2013-01-01 5:42 AM")).decorate
        expect(batch.created_at_string).to eq "January 1st, 2013 5:42am"
      end
    end

  end

end
