class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    first = @tweets.first.tweeted_at
    last = @tweets.last.tweeted_at
    @schedules = Schedule.where("start_at between ? and ? or finish_at between ? and ?", 
      first.to_s(:db), last.to_s(:db), first.to_s(:db), last.to_s(:db)
    )
    @mentions = Mention.where("twitter not in  ('@sxsw', '@foursquare')").group(:twitter).order("count(*) desc").limit(10)
    @sorted_mentions = @mentions.count.sort{|a, b| b[1] <=> a[1]}.map do |a| 
      if speaker = Speaker.find_by_twitter(a.first)
        # raise speaker.schedule.inspect
       a << [speaker.schedule]
      end
      a
    end
    # @mentions_tweets = Tweet.joins(:mentions).where("twitter in  (?)", @mentions.map{|m| m.twitter}).
    #   group('mentions.twitter', 'concat(YEAR(tweeted_at), "/",   MONTH(tweeted_at), "/", DAY(tweeted_at), " ", HOUR(tweeted_at) , ":", MINUTE(tweeted_at))').count
    # b = @mentions_tweets.reduce({}) do |a,b|
    #   mention = b[0][0]
    #   a[mention] = a[mention]
    #   unless a[mention]
    #     a[mention] = {}
    #   else
    #     a[mention] = a[mention] + 1
    #   end
    #   a
    # end
  end
end
