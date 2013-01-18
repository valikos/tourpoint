class Location < ActiveRecord::Base
  attr_accessible :title, :description, :latitude, :longitude, :tour_id

  belongs_to :tour
end
