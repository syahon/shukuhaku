class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @room = Room.new
  end

  def index
    @pagy, @rooms = pagy(Room.recent)
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def search
    if params[:area]
      @pagy, @rooms = pagy(Room.look_area(params[:area]).recent)
    elsif params[:word]
      @pagy, @rooms = pagy(Room.look_word(params[:word]).recent)
    else
      redirect_to root_url
    end
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
