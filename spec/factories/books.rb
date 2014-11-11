FactoryGirl.define do
  factory :book do
    sequence(:id)
    sequence(:asin) { |n| "test#{n}" }
    sequence(:image) { |n| "image_#{n}.jpg" }
  end
end