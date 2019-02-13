class PlanesController < ApplicationController

  def index
    @planes = Plane.find_match(params)
    @load_origins = OriginCity.all
    @load_destinations = DestinationCity.all
    flash[:error] = ''
    if params[:pnr].present?
      seat = Seat.find_by(pnr: params[:pnr])
      if seat.present? && seat.seat_users?
        redirect_to plane_path(seat&.plane&.id, pnr: params[:pnr])
      else
        flash[:error] = "Your PNR is not match with any user"
      end
    end
  end

  def show
    @plane = Plane.find(params[:id])
    if params[:pnr].present?
      seat = Seat.find_by(pnr: params[:pnr])
      @user = params[:user_id].present? ? User.find(params[:user_id]) : seat.users.first
      @user_selected_seats = @user.seats&.uniq
    end
    @plane_seats = @plane.seats
  end

  def seat_vacancies
    plane = Plane.find(params[:plane_id])
    seat_vacancies = plane.plane_seats(params[:category_id])
    render :json => { seats: seat_vacancies, categories: plane.seat_categories }
  end
end
