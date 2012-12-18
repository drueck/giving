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

end
