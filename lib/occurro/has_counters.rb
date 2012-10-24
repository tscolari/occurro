module Occurro
  module HasCounters
    extend ActiveSupport::Concern

    included do
      has_one  :counter        , class_name: 'Occurro::Counter'      , dependent: :destroy , as: :countable
      has_many :daily_counters , class_name: 'Occurro::DailyCounter' , dependent: :destroy , as: :countable

      cattr_reader :occurro_counter_cache
      @@occurro_counter_cache = 1
    end

  end
end
