class User < ApplicationRecord
  belongs_to :match

  def end_turn
    self[:has_gone?] = true
    self.save
    next_user = self.match.users.find_by(has_gone?: false)
    if next_user == nil
      self.match[:ended] = true
      self.match.save
      return {ended: "game end"}
    end
    self[:your_turn?] = false
    self.save
    next_user[:your_turn?] = true
    next_user[:has_gone?] = true
    next_user.match.gen_answer
    next_user.match.save
    next_user.save
    return next_user
  end
end
