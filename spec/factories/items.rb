FactoryGirl.define do
  factory :item do
    sequence(:id)
    sequence(:rank)
    status 1
    sequence(:user_id)
    book_id 1
    sequence(:review) { |n| n.odd? ? "レビュー#{n}" : "" }
  end
end