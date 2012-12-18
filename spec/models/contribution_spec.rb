require 'spec_helper'

describe Contribution do

  describe 'amount=(a)' do

    before do
      @contribution = Contribution.new
    end

    context 'if the param is a float' do
      it 'should convert the param to a BigDecimal rounded to two decimal places' do
        @contribution.amount = 4.999
        @contribution.amount.should be_an_instance_of BigDecimal
        @contribution.amount.should eq BigDecimal.new('5.00', 8)
      end
    end

    context 'if the param is a string' do
      it 'should convert the param to a BigDecimal rounded to two decimal places' do
        @contribution.amount = '4.9843'
        @contribution.amount.should be_an_instance_of BigDecimal
        @contribution.amount.should eq BigDecimal.new('4.98', 8)
      end
    end

    context 'if the param is a BigDecimal' do
      it 'should convert the param to a new BigDecimal rounded to two decimal places' do
        @contribution.amount = BigDecimal.new('4.9853')
        @contribution.amount.should be_an_instance_of BigDecimal
        @contribution.amount.should eq BigDecimal.new('4.99', 8)
      end
    end

  end

end
