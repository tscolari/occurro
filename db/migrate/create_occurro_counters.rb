class CreateOccurroCounters < ActiveRecord::Migration
  def change
    create_table :occurro_counters do |t|
      t.references :countable  , polymorphic: true
      t.integer    :today      , default: 0 , null: false
      t.integer    :yesterday  , default: 0 , null: false
      t.integer    :this_week  , default: 0 , null: false
      t.integer    :last_week  , default: 0 , null: false
      t.integer    :this_month , default: 0 , null: false
      t.integer    :last_month , default: 0 , null: false
      t.timestamps
    end
    add_index :occurro_counters , [:countable_type , :countable_id] , unique: true , name: 'countable_unq'
    add_index :occurro_counters , [:countable_type , :today         , :yesterday]  , name: 'countable_type_daily'
    add_index :occurro_counters , [:countable_type , :this_month    , :last_month] , name: 'countable_type_monthly'
    add_index :occurro_counters , [:countable_type , :this_week     , :last_week]  , name: 'countable_type_weekly'
  end
end
