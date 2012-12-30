module Occurro
  module CachedCounter

    # Increments the counter based on the model counter_cache option.
    # If the counter_cache limit is not reached, it will store the value
    # on Rails.cache, and will submit it to persistence only when
    # there are as many entries as the counter_cache value
    #
    def self.increment_counter(model)
      cached_counts = Rails.cache.read(key_name(model)).to_i + 1
      return update_cached_counter(model, cached_counts) if cached_counts < model.class.counter_cache
      update_cached_counter(model, 0)
      Occurro::Jobs::Sender.increment_counters_job(model, cached_counts)
    end

    private

    # Returns the key name to the cache
    #
    def self.key_name(model)
      "counters_cache_#{model.class.base_class.name}_#{model.id}"
    end

    # Updates the cached counter with a new value
    #
    def self.update_cached_counter(model, count)
      Rails.cache.write(key_name(model), count)
    end

  end
end
