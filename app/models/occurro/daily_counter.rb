module Occurro
  class DailyCounter < ActiveRecord::Base
    validates :countable, :created_on, presence: true
    validates :created_on, uniqueness: { scope: [:countable_type, :countable_id] }

    belongs_to :countable, polymorphic: true

    def self.increment_counters(model, count = 1)
      counter =
        Occurro::DailyCounter.find_or_create_by({
          countable_type: model.class.base_class.name,
          countable_id: model.id,
          created_on: Date.today
        })
      counter.increment!(:total, count)
    end
  end
end
