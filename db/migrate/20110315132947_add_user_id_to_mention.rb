class AddUserIdToMention < ActiveRecord::Migration
  def self.up
    add_column :mentions, :user_id, :integer
  end

  def self.down
    remove_column :mentions, :user_id
  end
end