require 'spec_helper'

module Occurro
  describe Counter do

    let(:counter) { FactoryGirl.create(:counter) }
    let(:dummy)   { counter.countable }

    describe "#update_counter" do

      period_types = { 
        daily:   ['today', 'yesterday'], 
        weekly:  ['this_week', 'last_week'], 
        monthly: ['this_month', 'last_month']
      }

      period_types.keys.each do |period_type|
        it "should rotate #{period_types[period_type]} for #{period_type}" do
          counter.should_receive(:"#{period_types[period_type][1]}=").with(counter.send(:"#{period_types[period_type][0]}"))
          counter.should_receive(:"#{period_types[period_type][0]}=").with(0)
          counter.update_counter(period_type)
        end
      end
      
    end

    describe "#increase_counters" do
      it "should increase all current counters by the same factor" do
        old_counter = counter
        Occurro::Counter.increase_counters(dummy, 100)
        dummy.reload
        dummy.counter.today.should      == old_counter.today      + 100
        dummy.counter.this_week.should  == old_counter.this_week  + 100
        dummy.counter.this_month.should == old_counter.this_month + 100
      end
    end

  end
end

