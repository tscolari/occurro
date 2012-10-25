module Occurro
  module Jobs
    class Resque

      # Performs an async increment of the counter
      #
      def self.perform(countable_type, countable_id, count = 1)
        model = countable_type.constantize.find countable_id
        Occurro::Counter.increment_counters(model, count)
      end

    end
  end
end
