class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_channel"
    all_users = Match.all_users(params)
    ActionCable.server.broadcast 'match_channel', allUsers: all_users
  end

  def startGame(data)
    start = Match.start_game(data)
    ActionCable.server.broadcast 'match_channel', startGame: start
  end

  def takeAGuess(data)
    result = Match.take_a_guess(data)
    ActionCable.server.broadcast 'match_channel', guess: result
  end

  def endTurn(data)
    user = Match.end_turn(data)
    if user[:ended]
      ActionCable.server.broadcast 'match_channel', endGame: user
    else
      ActionCable.server.broadcast 'match_channel', endTurn: user
    end
  end

  def sendCanvas(data)
    drawing = Sketch.check_sketch(data)
    ActionCable.server.broadcast 'match_channel', canvas: drawing
  end

  def checkGameStatus(data)
    status = Match.check_status(data)
    ActionCable.server.broadcast 'match_channel', status: status
  end

  def sendToRobot(data)
    result = Match.check_robot(data)
    ActionCable.server.broadcast 'match_channel', robot: result

  end

  def recieved(data)
    MatchChannel.broadcast_to(@match, {match: @match})
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
