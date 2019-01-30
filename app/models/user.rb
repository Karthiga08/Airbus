class User < ApplicationRecord

  #associations
  has_many :user_seats, dependent: :destroy
  has_many :seats, through: :user_seats

  accepts_nested_attributes_for :user_seats

  def create_user_seats(seat_ids)
    return if seat_ids.nil?
    seat_ids = seat_ids.reject { |id| id.blank? }
    seat_ids.each do |seat|
      user_seats.create(seat_id: seat, user_id: id)
    end
    Seat.where(id: seat_ids).update(is_booked: true)
  end
end
