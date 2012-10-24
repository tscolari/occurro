module Occurro
  class DailyCounter < ActiveRecord::Base
    validates :countable, :created_on, presence: true
    validates :created_on, uniqueness: { scope: [:countable_type, :countable_id] }

    belongs_to :countable, polymorphic: true

    def self.increase_counters(model, count = 1)
      counter = Occurro::DailyCounter.find_or_create_by_countable_type_and_countable_id_and_created_on(model.class.name, model.id, Date.today)
      counter.increment!(:total, count)
    end
  end
end
