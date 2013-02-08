require 'spec_helper'

describe PlacesController do
  describe "POST 'create'" do
    before do
      controller.stub(:parse_lookups) { success }
      post :create, places: { location: 'Alabama' }
    end
    context "on success" do
      let(:success){ true }
      it { should assign_to(:location) }
      it { should respond_with(:created) }
    end
    context "on failure" do
      let(:success){ false }
      it { should assign_to(:location) }
      it { should respond_with(:unprocessable_entity) }
    end
  end
end
