class Tweet < ActiveRecord::Base
  has_many :users, :through => :mentions
  has_many :mentions
  has_many :mentions
  validates :id_str, :uniqueness => true
end
