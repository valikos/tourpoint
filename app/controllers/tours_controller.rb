class ToursController < ApplicationController

  before_filter :find_tour, only: [:show, :edit, :update, :destroy, :itinerary]
  before_filter :current_location, only: [:show, :itinerary]

  def index
    @tours = Tour.all
  end

  def show
    @locations = @tour.locations.order("locations.order")
    @markers = @locations.to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(:partial => "/locations/infowindow", :locals => { :location => location })
      marker.title   location.title
      marker.sidebar location.description
      marker.json({ :id => location.id, :foo => location.title })
    end
    @polylines = "[#{@markers}]"
  end

  def new
    @tour = Tour.new(active: false)
  end

  def create
    @tour = Tour.new(params[:tour])
    if @tour.save
      redirect_to itinerary_tour_url(@tour.id), notice: 'Tour created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tour.update_attributes(params[:tour])
      redirect_to itinerary_tour_url(@tour.id), notice: 'Tour updated'
    else
      render :edit
    end
  end

  def destroy
    @tour.destroy and redirect_to tours_path, notice: 'Tour deleted'
  end

  def itinerary
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

private

  def find_tour
    @tour = Tour.find(params[:id])
  end

  def current_location
    @request = [request.ip, request.location]
    @current_location = {}
    @current_location['lat'] = request.location.latitude rescue 0
    @current_location['lng'] = request.location.longitude rescue 0
  end
end
