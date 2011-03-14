class Tweet < ActiveRecord::Base
  has_many :mentions
  validates :id_str, :uniqueness => true
end
