require 'spec_helper'

module Occurro
  module Jobs
    describe Sender do
      let(:dummy) { FactoryGirl.create(:dummy_item) }

      describe "Sender Finding" do
        context "custom sender is false" do
          before(:each) { Occurro.class_variable_set(:@@custom_job, false) }

          it "should forward to Occurro::Counter" do
            Occurro::Counter.should_receive(:increment_counters).with(dummy, 5)
            Occurro::Jobs::Sender.send(:find_sender_for, dummy, 5)
          end
        end

        context "custom sender is :reque" do
          require 'resque'
          before(:each) { Occurro.class_variable_set(:@@custom_job, :resque) }

          it "should forward to Resque" do
            Resque.should_receive(:enqueue).with(Occurro::Jobs::Resque, dummy.class.name, dummy.id, 10)
            Resque.stub(:enqueue)
            Occurro::Jobs::Sender.send(:find_sender_for, dummy, 10)
          end
        end

        context "custom sender is :delayed_job" do
          require 'delayed_job_active_record'
          before(:each) { Occurro.class_variable_set(:@@custom_job, :delayed_job) }

          it "should forward to Resque" do
            Delayed::Job.should_receive(:enqueue).with(Occurro::Jobs::DelayedJob.new(dummy, 15))
            Occurro::Jobs::Sender.send(:find_sender_for, dummy, 15)
          end
        end

        context "custom sender is a custom proc" do

        end
      end

    end
  end
end
