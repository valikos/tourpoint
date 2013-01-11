require 'spec_helper'

describe Tour do

  describe "db table" do
    it { should have_db_column :title }
    it { should have_db_column :description }
    it { should have_db_column :price }
    it { should have_db_column :active }
    it { should have_db_column :start_date }
    it { should have_db_column :end_date }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :price }
    xit { should validate_presence_of :start_date }
    xit { should validate_presence_of :end_date }
  end
end
