class LocationsController < ApplicationController

  before_filter :find_tour, except: [:destroy, :sort]
  respond_to :json, only: [:destroy]

  def create
    @location = @tour.locations.build(params[:location])
    if @location.save
      partial = render_to_string(partial: 'locations/location',
        :locals => { location: @location })
      infovindow = render_to_string(:partial => "/locations/infowindow",
        :locals => { :location => @location })
      render json: [@location, partial: partial, infovindow: infovindow], status: :created,
        location: tour_locations_path
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def edit
    @location = @tour.locations.find(params[:id])
    render json: [@location, action_form: render_to_string(partial: 'locations/form')],
      status: :accepted
  end

  def update
    @location = @tour.locations.find(params[:id])
    if @location.update_attributes(params[:location])
      partial = render_to_string(partial: 'locations/location', :locals => { location: @location })
      infovindow = render_to_string(:partial => "/locations/infowindow", :locals => { :location => @location })
      render json: [@location, partial: partial, infowindow: infovindow], status: :ok
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @location = Location.where(id: params[:id], tour_id: params[:tour_id]).first
    # @location = Location.find(params[:id], conditions: { tour_id: params[:tour_id] })
    if @location && @location.destroy
      render json: @location, status: :accepted
    else
      head :no_content
    end
  end

  def sort
    params[:location].each_with_index do |id, index|
      Location.update_all({ order: index + 1 }, { id: id } )
    end
    render nothing: true
  end

private

  def find_tour
    @tour = Tour.find(params[:tour_id])
  end
end
