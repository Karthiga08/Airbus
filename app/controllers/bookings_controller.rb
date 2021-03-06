class BookingsController < ApplicationController

  def new
    plane = Plane.find(params[:plane_id])
    @plane_seats = plane.seats
    @user = User.new
    flash[:error] = ''
  end

  def create
    @user = User.new booking_params
    unless params[:user][:user_seat_ids].reject { |id| id.blank? }.empty?
      if @user.save
        @user.create_user_seats(params[:user][:user_seat_ids])
        redirect_to booking_successfull_booking_path(@user.id)
      else
        render 'new'
      end
    else
      plane = Plane.find(params[:user][:plane_id])
      @plane_seats = plane.seats
      flash[:error] = "You should select the available seat"
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
    seat = Seat.find(params[:seat_id])
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
    @booking_seats = @booking_user.seats.uniq
  end

  private
    def booking_params
      params.require(:user).permit(:name, :date_of_birth, :gener, :adult_count, :child_count, :infant_count, :email, :phone_number, user_seats_attributes: [:user_id, :seat_id])
    end
end
