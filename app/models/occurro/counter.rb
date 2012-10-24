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

  end
end
