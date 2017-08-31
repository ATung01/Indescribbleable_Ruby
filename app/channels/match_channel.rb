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
  end
end
