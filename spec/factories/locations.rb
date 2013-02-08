# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    sequence(:title) { |n| "Location #{n}" }
    sequence(:description) { Faker::Lorem.paragraph(2) }
    tour
  end
end
