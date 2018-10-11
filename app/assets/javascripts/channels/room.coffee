document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # メッセージをブロードキャストで受け取った時
      # id=messagesにdata['message']を表示させる
      $('#messages').append data['message']

    speak: (message)->
      # メッセージが送信された時
      # コンシューマになったRoomChannelのspeakアクションが呼ばれる
      @perform 'speak', message: message

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # returnキーで送信されるようにする
      #returnキーを押すとここで上のApp.roomの:speakが呼ばれる
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()
