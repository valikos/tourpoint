class Location < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false

  attr_accessible :title, :description, :latitude, :longitude, :tour_id

  belongs_to :tour

  validates :title, presence: true
  validates :description, presence: true

  def gmaps4rails_address
    ""
  end
end
