class AddUserIdToMention < ActiveRecord::Migration
  def self.up
    add_column :mentions, :user_id, :integer
  end

  def self.down
    remove_column :mentions, :user_id
  end
end

# Migration script
# Mention.all.each do |m|
#   m.user = User.find_or_create_by_twitter(m.twitter)
#   m.save!
# end
# 
