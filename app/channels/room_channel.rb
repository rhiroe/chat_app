class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}" #room_idを付け足して部屋を分ける[課題]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)  # current_userを定義しないとNameErrorになる(current_userがchannelで使えない)
    Message.create!(content: data['message'], user_id: current_user.id, room_id: params['room_id'])#ここにroom_idを取得[課題]
  end
end
