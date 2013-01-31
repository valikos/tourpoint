class ToursController < ApplicationController

  before_filter :get_tour, only: [:show, :edit, :update, :destroy]
  before_filter :current_location, only: :show

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
    @tour = Tour.new(start_date: Date.today.to_s(:db), end_date: Date.today.to_s(:db))
  end

  def create
    @tour = Tour.new(params[:tour])
    if @tour.save
      redirect_to tours_url, notice: 'Tour created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tour.update_attributes(params[:tour])
      redirect_to @tour, notice: 'Tour updated'
    else
      render :edit
    end
  end

  def destroy
    @tour.destroy and redirect_to tours_path, notice: 'Tour deleted'
  end

private

  def get_tour
    @tour = Tour.find(params[:id])
  end

  def current_location
    @current_location = {}
    @current_location['lat'] = request.location.latitude rescue 0
    @current_location['lng'] = request.location.longitude rescue 0
  end
end
