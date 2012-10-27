require 'spec_helper'

module Occurro
  describe CachedCounter do
    let(:model) { FactoryGirl.create(:dummy_item) }

    before(:each) do
      DummyItem.send(:occurro_configure) do |config|
        config[:counter_cache]      = 5
      end
    end

    describe "#increment_counter" do
      context "with counter cache reached" do

        (4..6).each do |cache_value|
          it "should forward to Occurro::Jobs::Sender with #{cache_value + 1}" do
            Occurro::CachedCounter.send(:update_cached_counter, model, cache_value)
            Occurro::Jobs::Sender.should_receive(:increment_counters_job).with(model, cache_value + 1)
            Occurro::CachedCounter.increment_counter(model)
          end
        end
        

      end

      context "without counter cache reached" do
        (0..3).each do |cache_value|
          it "should update the cached counter only with #{cache_value + 1}" do
            Occurro::CachedCounter.send(:update_cached_counter, model, cache_value)
            Occurro::Jobs::Sender.should_receive(:increment_counters_job).never
            Occurro::CachedCounter.should_receive(:update_cached_counter).with(model, cache_value + 1)
            Occurro::CachedCounter.increment_counter(model)
          end
        end
      end
    end

  end
end
