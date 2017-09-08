class Match < ApplicationRecord
  has_many :users
  has_one :sketch
  categories = ["easy", "medium", "difficult", "hard", "movies"]

  def gen_answer
    gen = GameWords::Generator.new
    self.answer = gen.words('pictionary').sample
  end

  def check_answer

  end

end
