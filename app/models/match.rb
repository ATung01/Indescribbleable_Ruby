class Match < ApplicationRecord
  has_many :users
  has_one :sketch
  categories = ["easy", "medium", "difficult", "hard", "movies"]

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

  def gen_answer
    gen = GameWords::Generator.new
    self.answer = gen.words('pictionary').sample
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

  def self.take_a_guess(data)
    current_match = Match.find_by(id: data['id'])
    current_guesser = User.find_by(id: data['current_user_ID'])
    current_drawer = User.find_by(id: data['current_turn_ID'])
    if current_match.answer == data['guess']
      current_guesser.points += 1000
      current_guesser.save
      current_drawer.points += 500
      current_drawer.save
      return {
        points: {
          currentUser: current_guesser.points,
          currentTurn: current_drawer.points
        }
      }
    else
      return {wrong: "wrong answer"}
    end

  end

  def self.all_users(data)
    current_match = Match.find_by(room_code: data['room'])
    all_users = current_match.users
  end

  def self.end_turn(data)
    current_user = User.find_by(id: data['currentTurnID'])
    return current_user.end_turn
  end

  def self.check_robot(data)
    current_match = Match.find_by(room_code: data['roomCode'])
    Sketch.call_robot(data["image"])
    new_sketch = Sketch.create(data: encoded_sketch)
  end

end
