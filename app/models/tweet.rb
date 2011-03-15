class Tweet < ActiveRecord::Base
  has_many :users, :through => :mentions
  has_many :mentions
  has_many :mentions
  validates :id_str, :uniqueness => true

  def self.summary
    @r ||= group('concat(YEAR(tweeted_at), "/",   MONTH(tweeted_at), "/", DAY(tweeted_at), " ", HOUR(tweeted_at) , ":", MINUTE(tweeted_at))').count
    @r.sort_by{|a, b| a[0] <=> b[1] }
  end
  
  def self.dates
    self.summary.map{|s| s[0]}.to_json
  end
  
  def self.numbers
    self.summary.map{|s| s[1]}.to_json
  end

end
