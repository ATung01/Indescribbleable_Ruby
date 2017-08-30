class MatchChannel < ApplicationCable::Channel
  def subscribed
    @match = Match.find_by(id: params[:room])
    stream_for @match
    # stream_from "some_channel"
  end

  def recieved(data)
    MatchChannel.broadcast_to(@match, {match: @match})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
