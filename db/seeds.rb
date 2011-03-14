# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'json'
File.open(RAILS_ROOT + "/db/seed/schedule.json").each do |schedule|
  if JSON.parse(schedule)["Time"]
    parsed = JSON.parse(schedule)
    start_at, finish_at = parsed["Time"].map{|t| Time.parse(t)}
    p s =  Schedule.create!(:start_at => start_at, :finish_at => finish_at, :content => schedule)
    if parsed["Speakers"]
      parsed["Speakers"].each do |speaker| 
        p s.speakers.create!(speaker)
      end
    end
  end
end

