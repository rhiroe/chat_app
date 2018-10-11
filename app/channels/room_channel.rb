class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # channelではdeviseで作成されたcurrent_userは使用できない
    Message.create!(content: data['message'], user_id: current_user.id, room_id: params['room_id'])
  end
end
