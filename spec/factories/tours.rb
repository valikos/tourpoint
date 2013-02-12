FactoryGirl.define do

  sequence :price do
    sprintf("%.2f", rand(0..99999.99))
  end

  factory :tour do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    price
    active false
    sequence(:start_date) { Date.today }
    sequence(:end_date) { |n| Date.today + n.days }

    trait "disable" do
      active false
    end
  end
end
