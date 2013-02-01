require "#{Rails.root}/lib/extras/geo_location"

class PlacesController < ApplicationController

  include GeoLocation

  def create
    if ( @location = parse_lookups(params[:places][:location]) ) && @location.present?
      render json: @location, status: :created, location: root_path
    else
      render json: @location, status: :unprocessable_entity
    end
  end
end
