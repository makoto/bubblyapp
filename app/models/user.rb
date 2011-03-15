class User < ActiveRecord::Base
  has_many :tweets, :through => :mentions
  has_many :mentions
end
