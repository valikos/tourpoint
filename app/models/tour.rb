class Tour < ActiveRecord::Base
  attr_accessible :title, :description, :price, :active, :start_date, :end_date

  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  # validates :start_date, presence: true
  # validates :end_date, presence: true
end
