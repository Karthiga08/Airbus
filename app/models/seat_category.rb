class SeatCategory < ApplicationRecord
  # Validations
  validates_presence_of :name, :number_of_seat_in_row, :number_of_rows, :price
  validates :number_of_rows, :number_of_seat_in_row,  format: { with: /\A\d+\z/, message: "Integer only" }

  #associations
  has_many :seats, dependent: :destroy
  belongs_to :plane

  accepts_nested_attributes_for :seats, allow_destroy: true

  after_create :generate_seats

  def generate_seats
    seats_count = number_of_rows * number_of_seat_in_row
    seats_count.times do |index|
      pnr_generate = name.first(2).to_s + "#{(SecureRandom.random_number(9e5) + 1e5).to_i}"
      seat_number = name.first(2) + (index + 1).to_s
      seats.create(plane_id: plane_id, seat_category_id: id, seat_number: seat_number, pnr: pnr_generate)
    end
  end

  def self.price_amount(category)
    find_by(name: category)&.price
  end
end
