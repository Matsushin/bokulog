FactoryGirl.define do
  factory :item do
    sequence(:id)
    asin 'test'
    sequence(:bookshelf_id)
    status 1
    sequence(:image) { |n| "image_#{n}.jpg" }
  end
end