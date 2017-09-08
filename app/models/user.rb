class User < ApplicationRecord
  belongs_to :match

  def end_turn
    self[:your_turn?] = false
    self[:has_gone?] = true
    self.save
    next_user = self.match.users.find_by(has_gone?: false)
    if next_user == nil
      return {status: "game end"}
    end
    next_user[:your_turn?] = true
    next_user.save
    return next_user
  end
end
