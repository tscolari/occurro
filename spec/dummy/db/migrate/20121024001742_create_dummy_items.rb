class CreateDummyItems < ActiveRecord::Migration
  def change
    create_table :dummy_items do |t|

      t.timestamps
    end
  end
end
