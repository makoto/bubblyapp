class ChangeContentType < ActiveRecord::Migration
  def self.up
    change_column :schedules, :content, :text
    # change_column :tweets, :content, :text
  end

  def self.down
    change_column :schedules, :content, :string
  end
end