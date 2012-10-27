module Occurro
  class Counter < ActiveRecord::Base
    attr_accessible :today, :this_week, :this_month, :total

    validates :countable, presence: true
    validates :countable_id, uniqueness: { scope: :countable_type }

    belongs_to :countable, polymorphic: true

    scope :order_by_today      , order('today DESC')
    scope :order_by_yesterday  , order('yesterday DESC')
    scope :order_by_this_week  , order('this_week DESC')
    scope :order_by_last_week  , order('last_week DESC')
    scope :order_by_this_month , order('this_month DESC')
    scope :order_by_last_month , order('last_month DESC')
    scope :order_by_total      , order('total DESC')



    # Public: Rotate the counter value for the period_type
    #
    # * period_type: 
    #   :daily   #=> daily rotation
    #   :weekly  #=> weekly rotation
    #   :monthly #=> monthly rotation
    #
    def update_counter(period_type)
      column_from, column_to =
        case period_type.to_s
        when 'daily'
          ['today', 'yesterday']
        when 'weekly'
          ['this_week', 'last_week']
        when 'monthly'
          ['this_month', 'last_month']
        else
          return false
        end

      self.send("#{column_to}=", self.send(column_from))
      self.send("#{column_from}=", 0)
      self.save 
    end

    # Public: increments 'model' counters by a 'count' factor
    #
    def self.increment_counters(model, count = 1)
      counter = Occurro::Counter.find_or_create_by_countable_type_and_countable_id(model.class.name, model.id)
      counter.update_attributes({
        :today      => counter.today      + count,
        :this_week  => counter.this_week  + count,
        :this_month => counter.this_month + count,
        :total      => counter.total      + count
      }) 
      Occurro::DailyCounter.increment_counters(model, count) if model.class.use_daily_counters?
    end

  end
end
