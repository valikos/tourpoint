class Tour < ActiveRecord::Base

  attr_accessible :title, :description, :price, :active, :start_date, :end_date

  has_many :locations, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_end_date, if: :presence_dates

  def duration
    (self.end_date - self.start_date).to_i + 1
  end

private

  def presence_dates
    start_date.present? && end_date.present?
  end

  def validate_end_date
    errors.add(:base, "Invalid dates") if end_date < start_date
  end
end
