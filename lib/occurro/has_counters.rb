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
    end

    module ClassMethods

      def use_daily_counters?
        #!!class_variable_get(:@@occurro_options)[:use_daily_counters]
        !!self.occurro_options[:use_daily_counters]
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

    private

  end
end
