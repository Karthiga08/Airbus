class Plane < ApplicationRecord
  #validations
  validates_presence_of :name, :plane_type, :plane_time

  #associationss
  has_many :seat_categories, dependent: :destroy
  has_many :seats, dependent: :destroy

  belongs_to :origin_city, dependent: :destroy
  belongs_to :destination_city,  dependent: :destroy

  accepts_nested_attributes_for :seat_categories, allow_destroy: true

  #search for flight
  def self.find_match(params)
    if params[:search].present?
      all.where("destination_city_id =? and origin_city_id =? and date =?", params[:destination_city_id], params[:origin_city_id], params[:date]) if params[:search].present?
    else
      all
    end
  end

  #select all seats based on category
  def plane_seats(category_id)
    seats.where(seat_category_id: category_id)
  end

  def plane_takeoff
    plane_time&.strftime("at %I:%M%p")
  end
end
