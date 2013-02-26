require 'spec_helper'

describe ToursController do
  let(:tour) { mock_model(Tour) }
  describe "GET 'index'" do
    let(:tours) { create_list :tour, 10 }
    before do
      get :index
    end
    it { should assign_to(:tours) }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end
  describe "GET 'show'" do
    let(:tour) { create :tour }
    let(:locations) { create_list :locations, 10, tour: tour.id }
    before do
      get :show, id: tour.id
    end
    it { should assign_to(:tour) }
    it { should assign_to(:locations) }
    it { should assign_to(:markers) }
    it { should assign_to(:polylines) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end
  describe "GET 'new'" do
    before do
      get :new
    end
    it { should assign_to(:tour) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end
  describe "POST 'create'" do
    context "mock" do
      before do
        Tour.stub(:new).and_return(tour)
        tour.stub(:save).and_return(success)
        post :create, tour: { 'title' => 'Test', 'description' => 'Test' }
      end
      context "on success" do
        let(:success) { true }
        it { should assign_to(:tour) }
        it { should respond_with(:redirect) }
        it { should set_the_flash }
        it { should redirect_to(itinerary_tour_url(tour.id)) }
      end
      context "on failure" do
        let(:success) { false }
        it { should assign_to(:tour) }
        it { should_not set_the_flash }
        it { should respond_with(:success) }
        it { should render_template(:new) }
      end
    end
  end
  describe "GET 'edit'" do
    let(:tour) { create :tour }
    before do
      get :edit, id: tour
    end
    it { should assign_to(:tour) }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
  end
  describe "PUT 'update'" do
    context "mock" do
      before do
        Tour.stub(:find).and_return(tour)
        tour.stub(:update_attributes).and_return(success)
        put :update, id: tour, tour: { 'title' => 'Test', 'description' => 'Test' }
      end
      context "on success" do
        let(:success) { true }
        it { should assign_to(:tour) }
        it { should respond_with(:redirect) }
        it { should set_the_flash }
        it { should redirect_to(itinerary_tour_url(tour.id)) }
      end
      context "on failure" do
        let(:success) { false }
        it { should assign_to(:tour) }
        it { should_not set_the_flash }
        it { should respond_with(:success) }
        it { should render_template(:edit) }
      end
    end
  end
  describe "DELETE 'destroy'" do
    context "mock" do
      before do
        Tour.stub(:find).and_return(tour)
        tour.stub(:destroy).and_return(success)
        delete :destroy, id: tour
      end
      context "on success" do
        let(:success) { true }
        it { should assign_to(:tour) }
        it { should respond_with(:redirect) }
        it { should set_the_flash }
        it { should redirect_to(tours_path) }
      end
    end
  end
  describe "GET 'itinerary'" do
    let(:tour) { create :tour }
    before do
      get :itinerary, id: tour.id
    end
    it { should assign_to(:tour) }
    it { should assign_to(:locations) }
    it { should assign_to(:location) }
    it { should assign_to(:markers) }
    it { should assign_to(:polylines) }
    it { should respond_with(:success) }
    it { should render_template(:itinerary) }
  end
end
