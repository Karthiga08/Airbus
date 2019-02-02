class BookingsController < ApplicationController

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

  def update
    @user = User.find(params[:id])
    @user.create_user_seats(params[:user][:user_seat_ids])
    redirect_to booking_successfull_booking_path(@user.id)
  end

  def upgrade_seats
    @user = User.find(params[:user_id])
    @user.create_user_seats(params[:selected_seats])
    seat = Seat.find_by(pnr: params["pnr_number"]&.split(": ").last)
    @user.user_cancel_seats(seat&.id)
    redirect_to booking_successfull_booking_path(@user.id)
  end

  def cancel_seats
    user = User.find(params[:id])
    user.user_cancel_seats(params[:seat_id])
    render :json => { message: 'Your booked seat cancelled successfully'}
  end

  def booking_successfull
    @booking_user = User.find(params[:id])
    @booking_seats = @booking_user.seats
  end

  private
    def booking_params
      params.require(:user).permit(:name, :date_of_birth, :gener, :adult_count, :child_count, :infant_count, :email, :phone_number, user_seats_attributes: [:user_id, :seat_id])
    end
end
