require 'spec_helper'

describe Contributor do

  describe '#destroy' do

    it 'deletes the record' do
      contributor = FactoryGirl.create(:contributor)
      id = contributor.id
      contributor.destroy
      Contributor.where(id: id).length.should eq 0
    end

  end

  describe '#<=>' do

    before do
      @aa = Contributor.create(last_name: 'a', first_name: 'a')
      @ab = Contributor.create(last_name: 'a', first_name: 'b')
      @ba = Contributor.create(last_name: 'b', first_name: 'a')
    end

    it 'compares contributors by last name then first name' do
      @aa.should be < @ab
      @ab.should be < @ba  
    end

  end

end
