module Occurro
  module Jobs
    class DelayedJob < Struct.new(:model, :count)

      def perform
        Occurro::Counter.increment_counters(model, count)
      end

    end
  end
end
