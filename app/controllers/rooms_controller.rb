class RoomsController < ApplicationController
  before_action :authenticate_user! # Deviseのメソッド

  def index
    @rooms = Room.all.order(:id)
  end

  def new
    Room.create!
    redirect_to root_path
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.order(:created_at)
  end
end
