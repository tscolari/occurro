class CreateOccurroDailyCounters < ActiveRecord::Migration
  def change
    create_table :occurro_daily_counters do |t|
      t.references :countable  , polymorphic: true
      t.integer    :total      , default: 0       , null: false 
      t.date       :created_on
      t.datetime   :updated_at
    end
    add_index :occurro_daily_counters, [:countable_type, :countable_id, :created_on], unique: true, name: 'daily_counter_unq'
    add_index :occurro_daily_counters, [:countable_type, :total], name: 'daily_counter_total'
  end
end
