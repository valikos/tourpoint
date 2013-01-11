require 'spec_helper'

describe ToursController do

  let(:tour) { mock_model(Tour) }

  describe "GET 'index'" do
    before do
      Tour.stub(:all).and_return([])

      get :index
    end

    it { should respond_with(:success) }
    it { should_not set_the_flash }
    it { should render_template(:index) }
    it { should assign_to(:tours) }
  end

  describe "GET 'show'" do
    before do
      Tour.stub(:find).and_return(tour)

      get :show, id: tour
    end

    it { should assign_to(:tour) }
    it { should respond_with(:success) }
    it { should render_template(:show) }

  end

  describe "GET 'new'" do
    before do
      Tour.stub(:new).and_return(tour)

      get :new
    end

    it { should assign_to(:tour) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
  end

  describe "POST 'create'" do
    before do
      Tour.stub(:new).and_return(tour)
      tour.stub(:save).and_return(success)

      post :create, tour: { 'title' => 'Test', 'description' => 'Test' }
    end

    context "on success" do
      let(:success) { true }

      it { should assign_to(:tour) }
      it { should respond_with(:redirect) }
      it { should redirect_to(tours_path) }
    end

    context "on failure" do
      let(:success) { false }

      it { should assign_to(:tour) }
      it { should_not set_the_flash }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end

  describe "GET 'edit'" do
    before do
      Tour.stub(:find).and_return(tour)

      get :edit, id: tour
    end

    it { should assign_to(:tour) }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
  end

  describe "PUT 'update'" do
    before do
      Tour.stub(:find).and_return(tour)
      tour.stub(:update_attributes).and_return(success)

      put :update, id: tour, tour: { 'title' => 'Test', 'description' => 'Test' }
    end

    context "on success" do
      let(:success) { true }

      it { should assign_to(:tour) }
      it { should respond_with(:redirect) }
      it { should redirect_to(tour_path) }
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
