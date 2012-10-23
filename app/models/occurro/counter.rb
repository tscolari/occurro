module Occurro
  class Counter < ActiveRecord::Base
    validates :countable, presence: true
    validates :countable_id, uniqueness: { scope: :countable_type }
  end
end
