class Location < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  attr_accessible :title, :description, :latitude, :longitude, :tour_id

  belongs_to :tour

  validates :title, presence: true
  validates :description, presence: true

  def position
    self.to_json(only: [:latitude, :longitude])
  end

  def position?
    latitude.present? && longitude.present?
  end
end
