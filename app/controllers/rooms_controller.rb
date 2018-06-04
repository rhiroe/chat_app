class RoomsController < ApplicationController
  before_action :authenticate_user!

  def home
    @rooms = Room.all
  end

  def new
    Room.create()
    redirect_to root_path
  end

  def show
    @room = Room.find(params[:room_id])
    @messages = @room.messages
  end
end
