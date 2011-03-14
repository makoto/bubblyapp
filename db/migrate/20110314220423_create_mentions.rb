class CreateMentions < ActiveRecord::Migration
  def self.up
    create_table :mentions do |t|
      t.string   :twitter
      t.integer  :tweet_id
      t.timestamps
    end
  end

  def self.down
    drop_table :mentions
  end
end
