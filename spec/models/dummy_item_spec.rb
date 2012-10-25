require 'spec_helper'

describe DummyItem do

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

end
