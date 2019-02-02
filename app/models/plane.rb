class Plane < ApplicationRecord
  #validations
  validates_presence_of :name, :plane_type, :origin, :destination

  #associationss
  has_many :seat_categories, dependent: :destroy
  has_many :seats, dependent: :destroy

  accepts_nested_attributes_for :seat_categories, allow_destroy: true

  before_create :downcase_stuff

  def self.find_match(params)
    if params[:search].present?
      all.where("destination like ? and origin like ? and date =?", params[:destination].downcase, params[:origin].downcase, params[:date]) if params[:search].present?
    else
      all
    end
  end

  def first_categories
    seat_categories.where(name: 'First Class').first
  end

  def business_categories
    seat_categories.where(name: 'Business Class').first
  end

  def economic_categories
    seat_categories.where(name: 'Economic Class').first
  end

  def plane_takeoff
    plane_time.strftime("at %I:%M%p")
  end

  private

  def downcase_stuff
    self.origin.downcase! && self.destination.downcase!
  end
end
