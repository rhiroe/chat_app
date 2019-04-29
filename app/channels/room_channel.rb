# frozen_string_literal: true

# action for each room you subscribe to
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # channel can not use current_user created with devise
    Message.create! content: data['message'], user_id: current_user.id, room_id: params['room_id']
  end
end
