FactoryGirl.define do
  factory :tour do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
  end
end