class ReservationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    reservation_build
    @reservation.total_price = @room.price * @reservation.sum_people * (@reservation.end_date - @reservation.start_date).to_i
    if @reservation.invalid?
      render template: 'rooms/show'
    end
  end

  def index
    @pagy, @reservations = pagy(Reservation.all.recent)
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
      params.require(:reservation).permit(:start_date, :end_date, :sum_people, :total_price)
    end

    def reservation_build
      @reservation = current_user.reservations.build(reservation_params)
      @room = Room.find(params[:id])
      @reservation.room_id = @room.id
    end
end
