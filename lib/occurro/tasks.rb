module Occurro
  module Tasks

    # Public: Update daily counters from counters table
    #
    def self.daily_update(countable_type = nil)
      update_counters(:daily, countable_type)
    end

    # Public: Update weekly counters from counters table
    #
    def self.weekly_update(countable_type = nil)
      update_counters(:weekly, countable_type)
    end

    # Public: Update monthly counters from counters table
    #
    def self.monthly_update(countable_type = nil)
      update_counters(:monthly, countable_type)
    end

    private

    # Private: Update counters for the period type and countable_type
    #
    def self.update_counters(period_type, countable_type = nil)
      counters = Occurro::Counter
      counters.where(updatable_type: countable_type) if countable_type
      counters.all.each do |counter|
        counter.update_counter(period_type)
      end
    end

  end
end
