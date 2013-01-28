class PlacesController < ApplicationController

  def create
    if ( @location = Geocoder.search(params[:places][:location]) ) && @location.present?
      render json: @location, status: :created, location: root_path
    else
      render json: @location, status: :unprocessable_entity
    end
  end
end
