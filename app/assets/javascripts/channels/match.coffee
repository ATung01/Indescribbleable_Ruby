App.match = App.cable.subscriptions.create "MatchChannel",

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

    # $('#messages').append data['message']
    alert data['message']

  speak: (message) ->
    @perform 'speak', message: message
