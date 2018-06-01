class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:room_id])
    @messages = @room.messages
  end
end
