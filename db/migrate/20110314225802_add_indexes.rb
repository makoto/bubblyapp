class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :mentions,  :twitter
    add_index :mentions,  :tweet_id
    add_index :schedules, :start_at
    add_index :schedules, :finish_at
    add_index :speakers,  :twitter
    add_index :speakers,  :schedule_id
    add_index :tweets,    :id_str
    add_index :tweets,    :tweeted_at
  end

  def self.down
    remove_index :tweets,    :tweeted_at
    remove_index :tweets,    :id_str
    remove_index :speakers,  :schedule_id
    remove_index :speakers,  :twitter
    remove_index :schedules, :finish_at
    remove_index :schedules, :start_at
    remove_index :mentions,  :tweet_id
    remove_index :mentions,  :twitter
  end
end
