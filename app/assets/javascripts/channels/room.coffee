document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # メッセージをブロードキャストで受け取った時
      # id=messagesにdata['message']を表示させる
      show_user = $('#show_user').data('show_user')
      console.log data['chat_user']
      console.log show_user
      if data['chat_user'] == show_user
        $('#messages').append data['message_right']
      else
        $('#messages').append data['message_left']

    speak: (message)->
      # メッセージが送信された時
      # コンシューマになったRoomChannelのspeakアクションが呼ばれる
      @perform 'speak', message: message

# Viewの'[data-behavior~=room_speaker]'内のtextを引数に実行される
# eventはここでは'[data-behavior~=room_speaker]'にあたる
$(document).on 'keydown', '[data-behavior~=room_speaker]', (event) ->
  # Ctrl + returnキーを押すとここで上のApp.roomの:speakが呼ばれる
  if event.ctrlKey && event.keyCode is 13
    # 引数eventのvalueをspeakアクションに渡す
    App.room.speak event.target.value
    # eventのvalueを初期化
    event.target.value = ''
    # 中身をsubmitしない
    event.preventDefault()

$(document).on 'click', '.chat_submit', ->
  App.room.speak $('[data-behavior~=room_speaker]').val()
  $('[data-behavior~=room_speaker]').val('')
  event.preventDefault()
