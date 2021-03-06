!#/usr/bin/ruby
require File.expand_path('../../config/environment', __FILE__)
require "rubygems"
require 'yaml'
require 'json'
require 'pusher'
require 'net/http'

ROOT_DIR = RAILS_ROOT
# keyword = ARGV[0]
keyword = "sxsw"
p ARGV[0]
config = YAML.load_file(ROOT_DIR + '/config/config.yml')
p ROOT_DIR
p ROOT_DIR + '/config/config.yml'
# outfile = (ROOT_DIR + "/data/#{keyword}.txt")

# mwc11
# @f = File.new(outfile, "a")
url = "http://stream.twitter.com/1/statuses/filter.json?track=#{keyword}"

Pusher.app_id = config[:app_id]
Pusher.key = config[:key]
Pusher.secret = config[:secret]

# from http://d.hatena.ne.jp/m_seki/?of=10
class JSONStream
  def initialize
    @buf = ''
  end

  def push(str)
    @buf << str
    while (line = @buf[/.+?(\r\n)+/m]) != nil
      begin
        @buf.sub!(line,"")
        line.strip!
        event = JSON.parse(line)
        id_str =  event["id_str"]
        tweeted_at =  event["created_at"]
        retweet_count =  event["retweet_count"]
        user_mentions = event["entities"]["user_mentions"].map{|u| u["screen_name"] if u}
        
        p t = Tweet.create!(:id_str => id_str, :tweeted_at => tweeted_at, :retweet_count => retweet_count, :content => line)
        user_mentions.each do |u|
          p t.mentions.create!(:twitter => "@" + u, :user => User.find_or_create_by_twitter("@" + u))
        end
        Pusher['twitter'].trigger!('created', event)
      rescue Exception => e
        p "ERROR"
        p e
        break
      end
    end
  end
end

uri = URI.parse(url)
p uri.request_uri
http = Net::HTTP.new(uri.host, uri.port)

 # occupy
 http.start do |https|
   json = JSONStream.new
   request = Net::HTTP::Get.new(uri.request_uri)
   request.basic_auth config[:account], config[:password] 
   http.request(request) do |response|
     response.read_body do |chunk|
       json.push(chunk)
     end
   end
 end