require "spec_helper"

describe "rendering location in a partial" do
  describe "edit form" do
    let(:location) { create :location }
    before do
      @tour = create :tour
      @location = create :location, tour_id: @tour.id
      render :partial => "locations/form"
    end
    it "should have update edited button" do
      rendered.should have_selector "#updateLocationInTourItenerary"
    end
    it "should have cancel edited button" do
      rendered.should have_selector "#closeEditLocationInTourItenerary"
    end
  end
  describe "new form" do
    before do
      @tour = create :tour
      @location = @tour.locations.build
      render :partial => "locations/form"
    end
    it "should have create button" do
      rendered.should have_selector "#addLocationToTourItenerary"
    end
  end
end
