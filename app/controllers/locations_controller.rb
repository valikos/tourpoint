class LocationsController < ApplicationController

  respond_to :json, only: [:destroy]
  before_filter :current_location, only: [:new, :edit]

  def new
    @tour = Tour.find(params[:tour_id])
    @locations = @tour.locations.order("locations.order")
    @location = @tour.locations.build
    @markers = @locations.to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(:partial => "/locations/infowindow",
        :locals => { :location => location })
      marker.title(location.title)
      marker.json({ id: location.id, order: location.order,
        title: location.title })
    end
    @polylines = "[#{@markers}]"
  end

  def create
    @tour = Tour.find(params[:tour_id])
    order = @tour.locations.count + 1
    @location = @tour.locations.build(params[:location])
    @location.order = order
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
    @tour = Tour.find(params[:tour_id])
    @location = @tour.locations.find(params[:id])
    render json: [@location, action_form: render_to_string(partial: 'locations/form')],
      status: :accepted
  end

  def update
    @tour = Tour.find(params[:tour_id])
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
    begin
    @location = Location.find(params[:id], conditions: { tour_id: params[:tour_id] })
    rescue ActiveRecord::RecordNotFound
      head :no_content
    else
      if @location.destroy
        render json: @location, status: :accepted
      else
        head :no_content
      end
    end
  end

  def sort
    params[:location].each_with_index do |id, index|
      Location.update_all({ order: index + 1 }, { id: id } )
    end
    render nothing: true
  end

private

  def current_location
    @current_location = {}
    @current_location['lat'] = request.location.latitude rescue 0
    @current_location['lng'] = request.location.longitude rescue 0
  end
end
