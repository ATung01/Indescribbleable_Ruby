class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_channel"
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
