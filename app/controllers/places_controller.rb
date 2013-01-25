class PlacesController < ApplicationController

  def create
    if ( @location = Geocoder.search(params[:places][:location]) )
      render json: @location, status: :created, location: root_path
    else
      render json: @location, status: :unprocessable_entity
    end
  end
end
