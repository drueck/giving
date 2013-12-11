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
