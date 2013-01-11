class Tour < ActiveRecord::Base
  attr_accessible :title, :description, :active, :start_date, :end_date

  validates :title, presence: true
  validates :description, presence: true
  # validates :start_date, presence: true
  # validates :end_date, presence: true
end
