class Tweet < ActiveRecord::Base
  has_many :mentions
end
