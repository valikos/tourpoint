require 'spec_helper'

describe "Location selectors" do
  let(:tour) { create :tour, title: 'Test Tour' }

  before(:each) do
    FactoryGirl.create_list(:location, 5, tour: tour)
    visit itinerary_tour_path(tour.id)
  end

  it { page.should have_selector "#new_location" }
  it { page.should have_selector "#place_location" }
  it { page.should have_selector "#location-select" }
  it { page.should have_selector "#addLocationToTourItenerary" }
  it { page.should have_selector "#action-form" }
  it { page.should have_selector "div#location-select" }
  it { page.should have_selector ".start_edit_location" }
  it { page.should have_selector ".drag-handle.icon-move" }
  it { page.should have_selector ".remove_itinerary" }
  it { page.should have_selector "#updatedAlert" }
  it { page.should have_selector "#createdAlert" }
  it { page.should have_link "Home" }
  it { page.should have_link "Tour" }
  it { page.should have_link "Preview your itinerary" }
  it { page.should have_button "Locate on map" }
  it { page.should have_content 'Test Tour' }
end
