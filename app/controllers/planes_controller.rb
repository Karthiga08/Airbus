class PlanesController < ApplicationController

  def index
    @planes = Plane.find_match(params)
    flash[:error] = ''
    if params[:pnr].present?
      seat = Seat.find_by(pnr: params[:pnr])
      if seat.present? && seat.users.any?
        redirect_to plane_path(seat&.plane&.id, pnr: params[:pnr])
      else
        flash[:error] = "Your PNR is not match with any Plane"
      end
    end
  end

  def show
    @plane = Plane.find(params[:id])
    if params[:pnr].present?
    seat = Seat.find_by(pnr: params[:pnr])
    @user = seat.users.first
    @user_selected_seats = @user.seats&.uniq
    end
    first_class = @plane.first_categories
    business_class = @plane.business_categories
    economic_class = @plane.economic_categories
    @first_class_seat_count = first_class.number_of_seat_in_row
    @business_class_seat_count = business_class.number_of_seat_in_row
    @economic_class_seat_count = economic_class.number_of_seat_in_row
    @first_class_seats =  first_class.seats
    @business_class_seats = business_class.seats
    @economic_class_seats = economic_class.seats
    @plane_seats = @plane.seats
  end

  def seat_vacancies
    plane = Plane.find(params[:plane_id])
    seat_vacancies = plane.seats.where(seat_category_id: params[:category_id])
    render :json => { seats: seat_vacancies, categories: plane.seat_categories }
  end
end
