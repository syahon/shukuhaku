class ReservationsController < ApplicationController
  def new
    reservation_build
    if @reservation.invalid?
      render template: 'rooms/show'
    end
  end

  def index
  end

  def create
    reservation_build
    if params[:back]
      render template: 'rooms/show'
    elsif @reservation.save
      flash[:success] = "予約しました"
      redirect_to reservations_url
    else
      flash.now[:danger] = "予約に失敗しました もう一度お試しください"
      render template: 'rooms/show'
    end
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :sum_people)
    end

    def reservation_build
      @reservation = current_user.reservations.build(reservation_params)
      @room = Room.find(params[:id])
      @reservation.room_id = @room.id
    end
end
