class Seat < ApplicationRecord
  default_scope { order(id: :asc) }
  #associations
  belongs_to :seat_category
  belongs_to :plane

  has_many :user_seats, dependent: :destroy
  has_many :users, through: :user_seats, dependent: :destroy
end
