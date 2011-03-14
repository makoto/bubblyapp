class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer  :id_str
      t.integer  :retweet_count
      t.datetime :tweeted_at
      t.string   :content
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
