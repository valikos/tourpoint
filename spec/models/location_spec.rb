require 'spec_helper'

describe Location do
  describe "factory" do
    it "should be valid" do
      build(:location).should be_valid
    end
  end
  describe "db table" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:latitude).of_type(:float) }
    it { should have_db_column(:longitude).of_type(:float) }
    it { should have_db_column(:tour_id).of_type(:integer) }
  end
  describe "associations" do
    it { should belong_to(:tour) }
  end
  describe "validations" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(70) }
    it { should validate_presence_of :description }
  end
  describe "custom methods" do
    context "when location without lat and lng" do
      subject { build :location }
      its(:position?) { should be_false }
    end
  end
end
