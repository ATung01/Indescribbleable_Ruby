class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_channel"
  end

  def startGame(data)
    start = Match.start_game(data)
    ActionCable.server.broadcast 'match_channel', startGame: start
  end

  # def addUsers(data)
  #   all_users = Match.add_users(data)
  #   ActionCable.server.broadcast 'match_channel', allUsers: all_users
  # end

  def endTurn(data)
    user = Match.end_turn(data)
    ActionCable.server.broadcast 'match_channel', endTurn: user
  end

  def sendCanvas(data)
    drawing = Sketch.check_sketch(data)
    ActionCable.server.broadcast 'match_channel', canvas: drawing
  end

  def checkGameStatus(data)
    status = Match.check_status(data)
    ActionCable.server.broadcast 'match_channel', status: status
  end

  def recieved(data)
    MatchChannel.broadcast_to(@match, {match: @match})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
