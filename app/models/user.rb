class User < ApplicationRecord

  #validations
  validates_presence_of :name, :date_of_birth, :gener, :phone_number, :email

  #associations
  has_many :user_seats, dependent: :destroy
  has_many :seats, through: :user_seats

  accepts_nested_attributes_for :user_seats

  def create_user_seats(seat_ids)
    return if seat_ids.nil?
    seat_ids = seat_ids.reject { |id| id.blank? }
    seat_ids.each do |seat|
      next unless Seat.find(seat).present?
      user_seats.create(seat_id: seat, user_id: id)
    end
    Seat.where(id: seat_ids).update(is_booked: true)
  end


  def user_cancel_seats(seat_id)
    Seat.find(seat_id).update(is_booked: false)
    user_seats.where(seat_id: seat_id, user_id: id).destroy_all
  end
end
