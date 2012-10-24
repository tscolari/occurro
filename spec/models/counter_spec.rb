require 'spec_helper'

module Occurro
  describe Counter do

    let(:counter) { FactoryGirl.build(:counter) }

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
  end
end

