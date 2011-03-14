class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.datetime :start_at
      t.datetime :finish_at
      t.string :content
      t.string :href
      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end