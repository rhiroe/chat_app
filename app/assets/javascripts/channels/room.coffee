document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->
      console.log("connected OK")
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log("received OK")
      $('#messages').append data['message']

    speak: (message)->
      @perform 'speak', message: message #@perform 'speak'でRoomChannelのspeakアクションが呼ばれる

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    console.log("keypress OK")
    if event.keyCode is 13 # return = send
      App.room.speak event.target.value #returnを押すとここで上のspeakが呼ばれる
      event.target.value = ''
      event.preventDefault()
