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

  def self.check_status(data)
    current_match = Match.find_by(id: data['id'])
    if current_match.users.find_by(your_turn?:true)
      my_turn = true
    else
      my_turn = false
    end
    status = {
      users: current_match.users,
      started: current_match.started,
      sketch: current_match.sketch ? current_match.sketch : "",
      current_turn: current_match.users.find_by(your_turn?: true)
    }
  end

end
