require 'spec_helper'

describe Tour do
  describe "factory" do
    it "should be valid" do
      build(:tour).should be_valid
    end
  end
  describe "db table" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:price).of_type(:decimal) }
    it { should have_db_column(:active).of_type(:boolean) }
    it { should have_db_column(:start_date).of_type(:date) }
    it { should have_db_column(:end_date).of_type(:date) }
  end
  describe "associations" do
    it { should have_many(:locations) }
  end
  describe "validations" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_most(255) }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :price }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end
  describe "cutom methods" do
    context "with all dates" do
      subject { build :tour }
      its(:presence_dates) { should be_true }
    end
    context "without start date" do
      subject { build :tour, start_date: nil }
      its(:presence_dates) { should be_false }
    end
    context "without end date" do
      its(:presence_dates) { should be_false }
    end
    context "when end date less than start date" do
      subject { build :tour, start_date: Date.today, end_date: Date.today - 1.week }
      before { subject.valid? }
      it "should add validation error" do
        subject.errors[:base].should include 'Invalid dates'
      end
    end
  end
end
