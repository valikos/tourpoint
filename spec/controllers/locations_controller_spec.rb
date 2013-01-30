require 'spec_helper'

describe LocationsController do

  describe "GET 'new'" do
    let(:tour){ mock(Tour) }
    let(:location){ mock_model(Location) }

    before do
      Tour.stub(:find).with("1").and_return(tour)
      tour_locations = mock(Object)
      locations = tour.stub(:locations).and_return( tour_locations )
      tour_locations.stub(:order).with("locations.order").and_return([])
      tour_locations.stub(:build).and_return(location)

      get :new, tour_id: 1
    end

    it { should assign_to(:tour) }
    it { should assign_to(:locations) }
    it { should assign_to(:location) }
    it { should respond_with(:success) }
    it { should respond_with_content_type(:html) }
    it { should render_template(:new) }
  end

  describe "POST 'create'" do
    context "factory" do
      let(:tour) { create :tour }

      context "on success" do
        let(:locations) { tour.locations.count }
        let(:location) { attributes_for :location, tour_id: tour.id }

        context "database" do
          it "should change Location count by 1" do
            expect{ post :create, tour_id: tour.id, location: location }.to change(Location, :count).by(1)
          end
        end

        before do
          post :create, tour_id: tour.id, location: location
        end

        it { should assign_to(:tour) }
        it { should assign_to(:location) }
        it { should respond_with(:created) }
        it { should respond_with_content_type(:json) }
      end

      context "on failure" do
        let(:locations) { tour.locations.count }

        context "database" do
          it "should change Location count by 1" do
            expect{ post :create, tour_id: tour.id, location: {} }.to_not change(Location, :count).by(1)
          end
        end

        before do
          post :create, tour_id: tour.id, location: {}
        end

        it { should assign_to(:tour) }
        it { should assign_to(:location) }
        it { should respond_with(:unprocessable_entity) }
        it { should respond_with_content_type(:json) }
      end
    end
  end

  describe "GET 'edit'" do
    let(:location){ create :location}
    before do
      get :edit, tour_id: location.tour.id, id: location.id
    end

    it { should assign_to(:tour) }
    it { should assign_to(:location) }
    it { should respond_with(:accepted) }
    it { should respond_with_content_type(:json) }
  end

  describe "PUT 'update'" do
    let(:tour) { create :tour }
    let(:location) { create :location, tour: tour }

    context "on success" do
      let(:location_updates) { attributes_for :location }
      before do
        put :update, tour_id: tour.id, id: location.id, location: location_updates
      end

      it { should assign_to(:tour) }
      it { should assign_to(:location) }
      it { should respond_with(:ok) }
      it { should respond_with_content_type(:json) }
    end

    context "on failure" do
      let(:location_updates) { attributes_for :location, title: '', description: '' }
      before do
        put :update, tour_id: tour.id, id: location.id, location: location_updates
      end

      it { should assign_to(:tour) }
      it { should assign_to(:location) }
      it { should respond_with(:unprocessable_entity) }
      it { should respond_with_content_type(:json) }
    end
  end

  describe "DELETE 'destroy'" do
    let(:tour) { create :tour }
    context "on success" do
      let(:location) { create :location, tour_id: tour.id }

      before do
        delete :destroy, tour_id: tour.id, id: location.id
      end

      it { should assign_to(:location) }
      it { should respond_with(:accepted) }
      it { should respond_with_content_type(:json) }
    end
    context "on failure" do
      let(:location) { create :location, tour_id: tour.id }

      context "missing or invalid tour id" do
        before do
          delete :destroy, tour_id: '', id: location.id
        end

        it { should respond_with(:no_content) }
      end

      context "missing or invalid location id" do
        before do
          delete :destroy, tour_id: tour.id, id: ''
        end

        it { should respond_with(:no_content) }
      end

      context "missing all attributes" do
        before do
          delete :destroy, tour_id: '', id: ''
        end

        it { should respond_with(:no_content) }
      end
    end
  end

  describe "POST 'sort'" do
    let(:tour) { create :tour }

    let(:loc1) { create :location, tour_id: tour.id }
    let(:loc2) { create :location, tour_id: tour.id }
    let(:loc3) { create :location, tour_id: tour.id }
    let(:loc4) { create :location, tour_id: tour.id }

    before do
      post :sort, tour_id: tour.id, location: [loc1.id, loc2.id, loc3.id, loc4.id]
    end

    it { loc1.reload.order.should == 1 }
    it { loc2.reload.order.should == 2 }
    it { loc3.reload.order.should == 3 }
    it { loc4.reload.order.should == 4 }
  end
end

__END__

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe LocationsController do

  # This should return the minimal set of attributes required to create a valid
  # Location. As you add validations to Location, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {  }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LocationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all locations as @locations" do
      location = Location.create! valid_attributes
      get :index, {}, valid_session
      assigns(:locations).should eq([location])
    end
  end

  describe "GET show" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}, valid_session
      assigns(:location).should eq(location)
    end
  end

  describe "GET new" do
    it "assigns a new location as @location" do
      get :new, {}, valid_session
      assigns(:location).should be_a_new(Location)
    end
  end

  describe "GET edit" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes
      get :edit, {:id => location.to_param}, valid_session
      assigns(:location).should eq(location)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Location" do
        expect {
          post :create, {:location => valid_attributes}, valid_session
        }.to change(Location, :count).by(1)
      end

      it "assigns a newly created location as @location" do
        post :create, {:location => valid_attributes}, valid_session
        assigns(:location).should be_a(Location)
        assigns(:location).should be_persisted
      end

      it "redirects to the created location" do
        post :create, {:location => valid_attributes}, valid_session
        response.should redirect_to(Location.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved location as @location" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post :create, {:location => {  }}, valid_session
        assigns(:location).should be_a_new(Location)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        post :create, {:location => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested location" do
        location = Location.create! valid_attributes
        # Assuming there are no other locations in the database, this
        # specifies that the Location created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Location.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => location.to_param, :location => { "these" => "params" }}, valid_session
      end

      it "assigns the requested location as @location" do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
        assigns(:location).should eq(location)
      end

      it "redirects to the location" do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => valid_attributes}, valid_session
        response.should redirect_to(location)
      end
    end

    describe "with invalid params" do
      it "assigns the location as @location" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put :update, {:id => location.to_param, :location => {  }}, valid_session
        assigns(:location).should eq(location)
      end

      it "re-renders the 'edit' template" do
        location = Location.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Location.any_instance.stub(:save).and_return(false)
        put :update, {:id => location.to_param, :location => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes
      expect {
        delete :destroy, {:id => location.to_param}, valid_session
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      location = Location.create! valid_attributes
      delete :destroy, {:id => location.to_param}, valid_session
      response.should redirect_to(locations_url)
    end
  end
end
