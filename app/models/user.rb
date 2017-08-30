class User < ApplicationRecord
  belongs_to :match
  has_many :sketches  
end
