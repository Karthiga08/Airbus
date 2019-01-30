class PlanesController < ApplicationController
  def show
    @plane = Plane.find(params[:id])
    if params[:pnr].present?
    seat = Seat.find_by(pnr: params[:pnr])
    @user = seat.users.first
    @user_selected_seats = @user.seats
    end
    first_class = @plane.seat_categories.where(name: 'First Class').first
    business_class = @plane.seat_categories.where(name: 'Business Class').first
    economic_class = @plane.seat_categories.where(name: 'Economic Class').first
    @first_class_seat_count = first_class.number_of_seat_in_row
    @business_class_seat_count = business_class.number_of_seat_in_row
    @economic_class_seat_count = economic_class.number_of_seat_in_row
    @first_class_seats =  first_class.seats
    @business_class_seats = business_class.seats
    @economic_class_seats = economic_class.seats
    @plane_seats = @plane.seats
  end
end
