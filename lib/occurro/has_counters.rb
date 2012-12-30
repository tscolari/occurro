module Occurro
  module HasCounters
    extend ActiveSupport::Concern

    included do
      has_one  :counter        , class_name: 'Occurro::Counter'      , dependent: :destroy , as: :countable
      has_many :daily_counters , class_name: 'Occurro::DailyCounter' , dependent: :destroy , as: :countable

      cattr_accessor :occurro_options
      self.occurro_options = {
        counter_cache: 0,
        use_daily_counters: true
      }

      scope :order_by_today_views      , ->() { joins(:counter).order('today DESC') }
      scope :order_by_yesterday_views  , ->() { joins(:counter).order('yesterday DESC') }
      scope :order_by_this_week_views  , ->() { joins(:counter).order('this_week DESC') }
      scope :order_by_last_week_views  , ->() { joins(:counter).order('last_week DESC') }
      scope :order_by_this_month_views , ->() { joins(:counter).order('this_month DESC') }
      scope :order_by_last_month_views , ->() { joins(:counter).order('last_month DESC') }
      scope :order_by_total_views      , ->() { joins(:counter).order('total DESC') }
    end

    # Public: Increments the counter in 1 for this model
    #
    def increment_counter
      return Occurro::CachedCounter.increment_counter(self) if self.class.base_class.counter_cache > 0
      Occurro::Jobs::Sender.increment_counters_job(self, 1)
    end

    module ClassMethods

      def use_daily_counters?
        !!self.occurro_options[:use_daily_counters]
      end

      def counter_cache
        self.occurro_options[:counter_cache]
      end

      private

      # Model Configuration
      #
      # Options:
      #
      #   * counter_cache (int) -> How many recipes will be cached in memory before
      #                            submiting them to persistence. Default: 0
      #
      #   * use_daily_counters (bool) -> Will keep track of daily counters?
      #                                  this will use an extra table to record
      #                                  counter by model and date. Default: false
      #
      # Example:
      #
      #   class Article < ActiveRecord::Base
      #     include Occurro::HasCounters
      #
      #     occurro_configure do |config|
      #       config[:counter_cache]      = 10
      #       config[:use_daily_counters] = false
      #     end
      #   end
      #
      def occurro_configure
        yield(self.occurro_options)
      end
    end
  end
end
