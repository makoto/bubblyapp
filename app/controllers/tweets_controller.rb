class TweetsController < ApplicationController
  def index
    default_hour = params[:hour] ? params[:hour].to_i : 1
    time = default_hour.hour.ago.to_s(:db)
    @tweets = Tweet.where("tweeted_at > ?", time)
    if @tweets.empty?
      # Set default
      time = 10.days.ago.to_s(:db) 
      @tweets = Tweet.where("tweeted_at > ?", time)
    end
    
    summary = @tweets.group('concat(YEAR(tweeted_at), "/",   MONTH(tweeted_at), "/", DAY(tweeted_at), " ", HOUR(tweeted_at) , ":", MINUTE(tweeted_at))').
    count.sort_by{|a, b| a[0] <=> b[1] }
    
    @summary_dates = summary.map{|s| s[0]}.to_json
    @summary_numbers = summary.map{|s| s[1]}.to_json
    # raise @summary_numbers.inspect
    first = @tweets.first.tweeted_at
    last = @tweets.last.tweeted_at
    @tpm =( @tweets.size / (last - first) * 60).to_i
    
    @mentions = Mention.joins(:tweet).where("tweets.tweeted_at > ? and twitter not in  ('@sxsw', '@foursquare')", time).group(:twitter).order("count(*) desc").limit(100)
    @speakers = Speaker.includes(:schedule).where("twitter in (?)", @mentions.map{|m| m.twitter})

    #Need to massively refactor
    @mentions_summary = @mentions.count.reduce({}) do |a, b| 
      name = b[0] 
      schedule = if speaker = @speakers.select{|s| s.twitter == name}[0]
       speaker.schedule
      end
      a[name] = {:count => b[1], :speaker => schedule}
      a
    end
  end
end
