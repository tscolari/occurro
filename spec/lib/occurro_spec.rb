require 'spec_helper'

describe Occurro do

  context "configuration" do
    it "should have the custom_job option" do
      Occurro.class_variable_set(:@@custom_job, false)
      Occurro.configure do |config|
        config.custom_job = :resque
      end
      Occurro.custom_job.should == :resque
    end
  end

end
