class Tweet < ActiveRecord::Base
  has_many :mentions
  validates :id_str, :uniqueness => true

  def self.summary
    group('concat(YEAR(tweeted_at), "/",   MONTH(tweeted_at), "/", DAY(tweeted_at), " ", HOUR(tweeted_at) , ":", MINUTE(tweeted_at))').count
  end

end
