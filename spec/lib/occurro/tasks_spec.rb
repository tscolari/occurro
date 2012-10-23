require 'spec_helper'

module Occurro
  describe Tasks do

    describe "Counter Updates" do
      [:daily, :weekly, :monthly].each do |period_type|
        before(:each) do
          Occurro::Tasks.stub(:update_counters).and_return(true)
        end

        context "#{period_type}" do
          it "should update the #{period_type}" do
            class_filter = "Test"
            Occurro::Tasks.should_receive(:update_counters).with(period_type, class_filter)
            Occurro::Tasks.send(:"#{period_type}_update", class_filter)
          end
        end
      end

      describe "#update_counters" do
        let (:stub_relation) do
          relation = mock()
          relation.stub(:all).and_return([])
        end

        context "with countable_type" do
          it "should select only counters for countable_type" do
            countable_type = 'Test'
            Occurro::Counter.stub(:where).and_return(stub_relation)
            Occurro::Counter.should_receive(:where).with(updatable_type: countable_type)
            Occurro::Counter.send(:update_counters, :daily, countable_type)
          end
        end

        it "should call model.update_counter with period_type" do
          counter_mock = mock
          counter_mock.stub(:update_counter).and_return(true)
          period_type  = :period_type
          Occurro::Counter.stub(:all).and_return(counter_mock)
          counter_mock.should_receive(:update_counter).with(period_type)
          Occurro::Counter.send(:update_counter).with(period_type)
        end
      end

    end

  end
end
