class Match < ApplicationRecord
  has_many :users
  has_one :sketch

  
end
