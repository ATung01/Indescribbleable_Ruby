class MatchChannel < ApplicationCable::Channel
  def subscribed
    all_users = Match.all_users(params)
    @match = Match.find_by(room_code: params['room'])
    stream_for @match
    MatchChannel.broadcast_to @match, allUsers: all_users
  end

  def startGame(data)
    @match = Match.find_by(room_code: params['room'])
    start = Match.start_game(data)
    MatchChannel.broadcast_to @match, startGame: start
  end

  def takeAGuess(data)
    @match = Match.find_by(room_code: params['room'])
    result = Match.take_a_guess(data)
    MatchChannel.broadcast_to @match, guess: result
  end

  def endTurn(data)
    @match = Match.find_by(room_code: params['room'])
    user = Match.end_turn(data)
    if user[:c_user][:ended]
      MatchChannel.broadcast_to @match, endGame: user
    else
      MatchChannel.broadcast_to @match, endTurn: user
    end
  end

  def sendCanvas(data)
    @match = Match.find_by(room_code: params['room'])
    drawing = Sketch.check_sketch(data)
    MatchChannel.broadcast_to @match, canvas: drawing
  end

  def checkGameStatus(data)
    @match = Match.find_by(room_code: params['room'])
    status = Match.check_status(data)
    MatchChannel.broadcast_to @match, status: status
  end

  def sendToRobot(data)
    @match = Match.find_by(room_code: params['room'])
    result = Match.check_robot(data)
    MatchChannel.broadcast_to @match, robot: result

  end

  def received(data)
    @match = Match.find_by(room_code: params['room'])
    MatchChannel.broadcast_to @match, match: @match
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
