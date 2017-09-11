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

  # def add_users(data)
  #
  # end

  def self.start_game(data)
    current_match = Match.find_by(room_code: data['roomCode'])
    current_match.started = true
    current_match.gen_answer
    current_match.save
    current_user = current_match.users.find_by(id: data['currentUserID'])
    current_user[:your_turn?] = true
    current_user.save
    return {current_match: current_match, all_users: current_match.users, current_turn: current_user}
  end

  def self.end_turn(data)
    current_user = User.find_by(id: data['currentTurnID'])
    return current_user.end_turn

  end

end
