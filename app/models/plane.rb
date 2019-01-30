class Plane < ApplicationRecord
  #validations
  validates_presence_of :name, :plane_type, :origin, :destination

  #associationss
  has_many :seat_categories, dependent: :destroy
  has_many :seats, dependent: :destroy

  accepts_nested_attributes_for :seat_categories, allow_destroy: true

  def self.find_match(destination, origin, date)
    all.where("destination like ? and origin like ? and date =?", destination.downcase, origin.downcase, date)
  end
end
