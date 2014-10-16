FactoryGirl.define do
  factory :review do
    sequence(:id)
    item_id 1
    sequence(:body) { |n| "レビュー#{n}" }
  end
end