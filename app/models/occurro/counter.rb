module Occurro
  class Counter < ActiveRecord::Base
    validates :countable, presence: true
    validates :countable_id, uniqueness: { scope: :countable_type }

    belongs_to :countable, polymorphic: true

    # Public: Rotate the counter value for the period_type
    #
    # * period_type:
    #   :daily   #=> daily rotation
    #   :weekly  #=> weekly rotation
    #   :monthly #=> monthly rotation
    #
    def update_counter(period_type)
      column_from, column_to = self.class.columns_to_shift(period_type)
      return unless column_from && column_to

      self.update_attributes({
        column_to => self[column_from],
        column_from => 0
      })
    end

    def self.update_counters(period_type)
      column_from, column_to = columns_to_shift(period_type)
      return unless column_from && column_to

      update_all("#{column_to} = #{column_from}, #{column_from} = 0")
    end

    # Public: increments 'model' counters by a 'count' factor
    #
    def self.increment_counters(model, count = 1)
      counter = Occurro::Counter.find_or_create_by(countable_type: model.class.base_class.name, countable_id: model.id)
      counter.update_attributes({
        :today      => counter.today      + count,
        :this_week  => counter.this_week  + count,
        :this_month => counter.this_month + count,
        :total      => counter.total      + count
      })
      Occurro::DailyCounter.increment_counters(model, count) if model.class.use_daily_counters?
    end

    def self.columns_to_shift(period_type)
      case period_type.to_s
      when 'daily'
        ['today', 'yesterday']
      when 'weekly'
        ['this_week', 'last_week']
      when 'monthly'
        ['this_month', 'last_month']
      else
        [false, false]
      end
    end

  end
end
