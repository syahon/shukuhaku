class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def index
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def search
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:success] = "ルーム情報を登録しました"
      redirect_to @room
    else
      render 'new'
    end
  end

  private
    def room_params
      params.require(:room).permit(:room_name, :introduction, :price, :address, :image)
    end
end
