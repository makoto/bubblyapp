class Mention < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :user
  
  def self.summary(time)
    mentions = self.joins(:tweet).where("tweets.tweeted_at > ? and twitter not in  ('@sxsw', '@foursquare')", time).group(:twitter).order("count(*) desc").limit(100)
    speakers = Speaker.includes(:schedule).where("twitter in (?)", mentions.map{|m| m.twitter})

    #Need to massively refactor
    @mentions_summary = mentions.count.reduce({}) do |a, b| 
      name = b[0] 
      schedule = if speaker = speakers.select{|s| s.twitter == name}[0]
       speaker.schedule
      end
      a[name] = {:count => b[1], :speaker => schedule}
      a
    end
  end
end
