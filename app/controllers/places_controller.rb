class PlacesController < ApplicationController

  def create
    if ( @location = Gmaps4rails.geocode(params[:places][:location]).first )
      render json: @location, status: :created, location: root_path
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end
end
