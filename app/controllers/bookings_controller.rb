class BookingsController < ApplicationController
  def index
    @planes = Plane.find_match(params[:destination], params[:origin], params[:date]) if params[:search].present?
    if params[:pnr].present?
      seat = Seat.find_by(pnr: params[:pnr])
      if seat.present?
        redirect_to plane_path(seat&.plane&.id, pnr: params[:pnr])
      else
        flash[:error] = "Your Pnr is not match with any Plane"
      end
    end
  end

  def new
    plane = Plane.find(params[:plane_id])
    @plane_seats = plane.seats
    @user = User.new
  end

  def create
    @user = User.new booking_params
    if @user.save
      @user.create_user_seats(params[:user][:user_seat_ids])
      redirect_to booking_successfull_booking_path(@user.id)
    else
      render 'new'
    end
  end

  def booking_successfull
    @booking_user = User.find(params[:id])
    @booking_seats = @booking_user.seats
  end

  def edit; end

  def update;end

  private
    def booking_params
      params.require(:user).permit(:name, :date_of_birth, :gener)
    end
end
