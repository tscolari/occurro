module Occurro
  module Jobs
    module Sender
      def self.increment_counters_job(model, count =1)
        find_sender_for(model, count)
      end

      private

      # Private: Based on Occurro.custom_sender it finds a sender
      # and send the increment_counter to it.
      #
      # Accepts 4 types of values:
      #
      # * false   => Will forward to model, and increment the counter in real time
      # * :resque => Will send it as a default ResqueJob
      # * :delayed_job => the model increment_counter through delayed job
      # * proc(model, count) => Any proc (or class that have call) and 
      #                         accepts model and count as paramenters.
      #
      def self.find_sender_for(model, count)
        case Occurro.custom_job
        when false, nil
          Occurro::Counter.increment_counters(model, count)
        when :resque, 'resque'
          Resque.enqueue Occurro::Jobs::Resque, model.class.name, model.id, count
        when :delayed_job, 'delayed_job'
          Delayed::Job.enqueue Occurro::Jobs::DelayedJob.new(model, count)
        else
          Occurro.custom_job.call(model, count)
        end
      end
    end
  end
end
