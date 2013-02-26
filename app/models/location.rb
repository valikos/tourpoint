class Location < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  attr_accessible :title, :description, :latitude, :longitude, :tour_id

  belongs_to :tour

  validates :title, presence: true,
    length: { maximum: 70 }
  validates :description, presence: true

  after_create :set_location_order

  def position
    self.to_json(only: [:latitude, :longitude])
  end

  def position?
    latitude.present? && longitude.present?
  end

private

  def set_location_order
    tour = self.tour
    self.order = tour.locations.count
    self.save!
  end

end
