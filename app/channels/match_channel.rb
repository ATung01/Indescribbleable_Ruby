class MatchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # Message.create! content: data['message']
    ActionCable.server.broadcast 'match_channel', message: data['message']
    # @match = Match.find_by(id: params[:room])
    # stream_for @match
    # stream_from "some_channel"
  end

  def recieved(data)
    MatchChannel.broadcast_to(@match, {match: @match})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
