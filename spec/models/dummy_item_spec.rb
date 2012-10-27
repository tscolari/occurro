require 'spec_helper'

describe DummyItem do
  let(:dummy) { FactoryGirl.create(:dummy_item) }

  context "configuration" do

    it "should update the options in the class" do
      DummyItem.class_variable_set(:@@occurro_options, {
        counter_cache: 0,
        use_daily_counter: true
      })

      DummyItem.send(:occurro_configure) do |config|
        config[:counter_cache]      = 0
        config[:use_daily_counters] = false
      end

      DummyItem.occurro_options[:counter_cache].should == 0
      DummyItem.occurro_options[:use_daily_counters].should == false
    end

  end

  describe "#increment_counter" do
    context "using counter cache" do
      before(:each) do
        DummyItem.send(:occurro_configure) do |config|
          config[:counter_cache]      = 5
        end
      end

      it "should use Occurro::CachedCounter to update the counter" do
        Occurro::CachedCounter.should_receive(:increment_counter).with(dummy)
        Occurro::CachedCounter.stub(:increment_counter).and_return(true)
        Occurro::Jobs::Sender.should_receive(:increment_counters_job).never
        dummy.increment_counter
      end

    end

    context "without counter cache" do
      before(:each) do
        DummyItem.send(:occurro_configure) do |config|
          config[:counter_cache]      = 0
        end
      end

      it "should use Occurro::Jobs::Sender directly" do
        Occurro::CachedCounter.should_receive(:increment_counter).never
        Occurro::Jobs::Sender.should_receive(:increment_counters_job).with(dummy, 1)
        Occurro::Jobs::Sender.stub(:increment_counters_job).and_return(true)
        dummy.increment_counter
      end
    end
  end

end
