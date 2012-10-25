require 'spec_helper'

module Occurro
  describe DailyCounter do

    let(:daily_counter) { FactoryGirl.create(:daily_counter) }
    let(:dummy)         { daily_counter.countable }
    
    describe "#increment_counters" do
      it "should increment the total attribute for the current date" do
        count = 235
        old_value = daily_counter.total
        DailyCounter.increment_counters(dummy, count)
        daily_counter.reload
        daily_counter.total.should == old_value + count 
      end
    end

  end
end
