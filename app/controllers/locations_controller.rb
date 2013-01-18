class LocationsController < ApplicationController
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
    @tour = Tour.find(params[:tour_id])
    @location = @tour.locations.build
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @location }
    # end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @location = @tour.locations.build(params[:location])
    if @location.save
      render json: @location, status: :created, location: tour_locations_path
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

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
end