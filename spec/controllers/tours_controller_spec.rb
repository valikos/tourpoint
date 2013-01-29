require 'spec_helper'

describe ToursController do

  let(:tour) { mock_model(Tour) }

  describe "GET 'index'" do
    context "mock" do
      before do
        Tour.stub(:all).and_return([])

        get :index
      end

      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should assign_to(:tours) }
    end
  end

  describe "GET 'show'" do
    context "mock" do
      before do
        Tour.stub(:find).and_return(tour)
        tour.stub(:locations).and_return([])

        get :show, id: tour
      end

      it { should assign_to(:tour) }
      it { should respond_with(:success) }
      it { should render_template(:show) }
    end
  end

  describe "GET 'new'" do
    context "mock" do
      before do
        Tour.stub(:new).and_return(tour)

        get :new
      end

      it { should assign_to(:tour) }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
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
  end

  describe "GET 'edit'" do
    context "mock" do
      before do
        Tour.stub(:find).and_return(tour)

        get :edit, id: tour
      end

      it { should assign_to(:tour) }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
    end
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
end
