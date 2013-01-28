class LocationsController < ApplicationController

  respond_to :json, only: [:destroy]
  before_filter :current_location, only: :new

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  def new
    @tour = Tour.includes(:locations).find(params[:tour_id])
    @locations = @tour.locations.order("locations.order")
    @location = @tour.locations.build
    @markers = @tour.locations.order("locations.order").to_gmaps4rails do |location, marker|
      # marker.infowindow render_to_string(:partial => "/locations/infowindow", :locals => { :location => location })
      marker.title   location.title
      marker.json({ :id => location.id, :order => location.order, :title => location.title })
    end
    @polylines = "[#{@markers}]"
  end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @tour = Tour.find(params[:tour_id])
    order = @tour.locations.length + 1
    @location = @tour.locations.build(params[:location])
    @location.order = order
    if @location.save
      partial = render_to_string(partial: 'locations/location', :locals => { location: @location })
      render json: [@location, partial: partial], status: :created, location: tour_locations_path
    else
      render json: @location.errors, status: :unprocessable_entity
    end
    # respond_to do |format|
      # if @location.save
        # format.html { redirect_to tour_locations_path, notice: 'Location was successfully created.' }
        # format.json { render json: @location, status: :created, location: @location }
      # else
      #   format.html { render action: "new" }
      #   format.json { render json: @location.errors, status: :unprocessable_entity }
      # end
    # end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location = Location.find(:first, conditions: { tour_id: params[:tour_id], id: params[:id]})
    if @location.destroy
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

  def current_location
    @current_location = {}
    @current_location['lat'] = reques.location.latitude rescue 0
    @current_location['lng'] = reques.location.longitude rescue 0
  end
end
