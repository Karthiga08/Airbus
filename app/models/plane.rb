class Plane < ApplicationRecord
  #validations
  validates_presence_of :name, :plane_type, :plane_time, :origin, :destination

  #associationss
  has_many :seat_categories, dependent: :destroy
  has_many :seats, dependent: :destroy

  accepts_nested_attributes_for :seat_categories, allow_destroy: true

  before_create :downcase_stuff

  #search for flight
  def self.find_match(params)
    if params[:search].present?
      all.where("destination like ? and origin like ? and date =?", params[:destination].downcase, params[:origin].downcase, params[:date]) if params[:search].present?
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

  private

  def downcase_stuff
    self.origin.downcase! && self.destination.downcase!
  end
end
