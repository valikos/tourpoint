class Tour < ActiveRecord::Base

  attr_accessible :title, :description, :price, :active, :start_date, :end_date

  has_many :locations, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_end_date

  def duration
    (self.end_date - self.start_date).to_i + 1
  end

private

  def validate_end_date
    errors.add(:base, "Invalid end date") if end_date < start_date
  end

end
