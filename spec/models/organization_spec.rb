require 'spec_helper'

describe Organization do

  describe '#address_lines' do
  
    context 'with all fields filled out' do

      before do
        @organization = FactoryGirl.create(:organization)
      end

      it 'should return an array of four lines' do
        @organization.address_lines.length.should eq 4
      end

      context 'and...' do

        it 'the first line should be the name' do
          @organization.address_lines[0].should eq "#{@organization.name}"
        end

        it 'the second line should be the address' do
          @organization.address_lines[1].should eq "#{@organization.address}"
        end

        it 'the third line should be the city, state zip' do
          @organization.address_lines[2].should eq "#{@organization.city}, #{@organization.state} #{@organization.zip}"
        end

        it 'the fourth line should be the phone' do
          @organization.address_lines[3].should eq "#{@organization.phone}"
        end

      end

    end  

    context 'with none of the fields filled out' do

      it 'should return an empty array' do
        organization = Organization.new
        organization.address_lines.length.should eq 0
      end

    end

  end

end
