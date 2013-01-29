require 'spec_helper'

describe Location do

  describe "db table" do
    it { should have_db_column :title }
    it { should have_db_column :description }
    it { should have_db_column :latitude }
    it { should have_db_column :longitude }
    it { should have_db_column :tour_id }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end
end
