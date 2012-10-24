module Occurro
  class DailyCounter < ActiveRecord::Base
    validates :countable, :created_on, presence: true
    validates :created_on, uniqueness: { scope: [:countable_type, :countable_id] }

    belongs_to :countable, polymorphic: true
  end
end
