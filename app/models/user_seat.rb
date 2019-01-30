class UserSeat < ApplicationRecord

  #associations
  belongs_to :user
  belongs_to :seat
end
